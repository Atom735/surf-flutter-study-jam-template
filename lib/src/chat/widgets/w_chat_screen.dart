import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/geolocation_data.dart';
import '../../service/service_interface.dart';
import '../../widgets/w_error_msgbox.dart';
import '../chat_message_data.dart';
import '../chat_user_data.dart';
import 'w_chat_msg_tile.dart';

class WChatScreen extends StatefulWidget {
  const WChatScreen(this.service, {Key? key}) : super(key: key);

  final IService service;

  @override
  State<WChatScreen> createState() => _WChatScreenState();
}

class _WChatScreenState extends State<WChatScreen> {
  late IService service;

  @override
  void initState() {
    super.initState();
    service = widget.service;
    tcUserName = TextEditingController(text: service.userName);
    tcUserName.addListener(() => service.userName = userName);
    refresh();
  }

  @override
  void dispose() {
    tcUserName.dispose();
    vnLoading.dispose();
    vnSending.dispose();
    super.dispose();
  }

  late TextEditingController tcUserName;
  String get userName => tcUserName.text;
  String msg = '';
  GeolocationData? geo;
  int msgId = 0;

  List<ChatMessageData> msgs = [];
  final vnLoading = ValueNotifier(false);
  final vnSending = ValueNotifier(false);

  void messagesHandle(List<ChatMessageData> data) {
    msgs = data;
    vnLoading.value = false;
    setState(() {});
  }

  void sendHandle(void _) {
    vnSending.value = false;
    msg = '';
    geo = null;
    msgId++;
    refresh();
  }

  void refresh() {
    vnLoading.value = true;
    setState(() {});
    service.getMessages().then(
          messagesHandle,
          onError: (e) => WErrorMsgBox.show(
            context,
            'Ошибка при получении сообщений',
            e.toString(),
          ),
        );
  }

  void sendMessage([Object? _]) {
    final geo = this.geo;
    if (userName.isEmpty) {
      WErrorMsgBox.show(
        context,
        'Ошибка при отправке сообщения',
        'Не заполнено поле "Имя пользователя"',
      );
      return;
    }
    if (geo == null && msg.isEmpty) {
      WErrorMsgBox.show(
        context,
        'Ошибка при отправке сообщения',
        'Сообщение не может быть пустым',
      );
      return;
    }
    vnSending.value = true;
    setState(() {});

    if (geo != null) {
      service
          .sendMessage(
              ChatMessageGeolocatedData(ChatUserData(userName), msg, geo))
          .then(
            sendHandle,
            onError: (e) => WErrorMsgBox.show(
              context,
              'Ошибка при отправке сообщения с геопозицонной меткой',
              e.toString(),
            ),
          );
    } else {
      service.sendMessage(ChatMessageData(ChatUserData(userName), msg)).then(
            sendHandle,
            onError: (e) => WErrorMsgBox.show(
              context,
              'Ошибка при отправке сообщения',
              e.toString(),
            ),
          );
    }
  }

  Future<void> attachGeo() async {
    if (geo == null) {
      await WErrorMsgBox.show(
          context,
          'Привязка геолокации',
          'Игнорируйте это сообщений, оно просто ещё не реализованно'
              '\n По закрытию будет привязанна случайное местоположение...');
      final r = Random(DateTime.now().microsecondsSinceEpoch);
      geo = GeolocationData(
          r.nextDouble() * 180 - 90, r.nextDouble() * 360 - 180);
      setState(() {});
    } else {
      await WErrorMsgBox.show(
          context,
          'Привязка геолокации',
          'Игнорируйте это сообщений, оно просто ещё не реализованно'
              '\n По закрытию метсоположения будет отвязано от сообщения...');
      geo = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: tcUserName,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              border: InputBorder.none,
              hintText: 'Имя пользователя',
            ),
          ),
          actions: [
            IconButton(
              onPressed: refresh,
              icon: const Icon(Icons.refresh),
              tooltip: 'Обновить список сообщений',
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: ValueListenableBuilder<bool>(
              valueListenable: vnLoading,
              builder: (context, value, child) =>
                  value ? const LinearProgressIndicator() : const SizedBox(),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true,
                children: msgs.map(WChatMsgTile.new).toList(),
              ),
            ),
            Material(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ValueListenableBuilder<bool>(
                  valueListenable: vnSending,
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (value) const LinearProgressIndicator(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: value ? null : attachGeo,
                            icon: const Icon(Icons.share_location_outlined),
                            tooltip: 'Прикрепить геопозицию',
                            color: geo == null
                                ? null
                                : Theme.of(context).colorScheme.primary,
                          ),
                          Expanded(
                            child: Actions(
                              actions: {
                                SubmitIntent: CallbackAction<SubmitIntent>(
                                    onInvoke: sendMessage),
                              },
                              child: Shortcuts(
                                shortcuts: {
                                  LogicalKeySet(LogicalKeyboardKey.control,
                                          LogicalKeyboardKey.enter):
                                      const SubmitIntent(),
                                },
                                child: TextField(
                                  key: ValueKey(msgId),
                                  onChanged: (value) => msg = value,
                                  onSubmitted: sendMessage,
                                  maxLines: null,
                                  enabled: !value,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Сообщение',
                                    suffixIcon: IconButton(
                                      onPressed: value ? null : sendMessage,
                                      icon: const Icon(Icons.send),
                                      tooltip: 'Отправить сообщение',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class SubmitIntent extends Intent {
  const SubmitIntent();
}

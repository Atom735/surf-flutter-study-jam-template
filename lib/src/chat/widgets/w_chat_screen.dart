import 'package:flutter/material.dart';

import '../../widgets/w_error_msgbox.dart';
import '../chat_message_data.dart';
import '../chat_repository_interface.dart';
import '../chat_user_data.dart';
import 'w_chat_msg_tile.dart';

class WChatScreen extends StatefulWidget {
  const WChatScreen(this.repo, {Key? key}) : super(key: key);

  final IChatRepository repo;

  @override
  State<WChatScreen> createState() => _WChatScreenState();
}

class _WChatScreenState extends State<WChatScreen> {
  late IChatRepository repo;

  @override
  void initState() {
    super.initState();
    repo = widget.repo;
    refresh();
  }

  String userName = '';
  String msg = '';
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
    msgId++;
    refresh();
  }

  void refresh() {
    vnLoading.value = true;
    setState(() {});
    repo.messages.then(
      messagesHandle,
      onError: (e) => WErrorMsgBox.show(
        context,
        'Ошибка при получении сообщений',
        e.toString(),
      ),
    );
  }

  void sendMessage([String _ = '']) {
    if (userName.isEmpty) {
      WErrorMsgBox.show(
        context,
        'Ошибка при отправке сообщения',
        'Не заполнено поле "Имя пользователя"',
      );
      return;
    }
    if (msg.isEmpty) {
      WErrorMsgBox.show(
        context,
        'Ошибка при отправке сообщения',
        'Сообщение не может быть пустым',
      );
      return;
    }
    repo.sendMessage(ChatMessageData(ChatUserData(userName), msg)).then(
          sendHandle,
          onError: (e) => WErrorMsgBox.show(
            context,
            'Ошибка при отправке сообщения',
            e.toString(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) => userName = value,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              border: InputBorder.none,
              hintText: 'Имя пользователя',
            ),
          ),
          actions: [
            IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
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
                padding: const EdgeInsets.all(8),
                child: ValueListenableBuilder<bool>(
                  valueListenable: vnSending,
                  builder: (context, value, child) => Column(
                    children: [
                      TextField(
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
                          ),
                        ),
                      ),
                      if (value) const LinearProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

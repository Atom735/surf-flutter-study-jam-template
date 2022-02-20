import 'package:flutter/material.dart';

import '../chat_message_data.dart';
import '../chat_repository_interface.dart';
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

  List<ChatMessageData> msgs = [];
  final vnLoading = ValueNotifier(false);

  void messagesHandle(List<ChatMessageData> data) {
    msgs = data;
    vnLoading.value = false;
    setState(() {});
  }

  void refresh() {
    vnLoading.value = true;
    repo.messages.then(messagesHandle);
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
          ],
        ),
      );
}

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
    repo.messages.then(messagesHandle);
  }

  List<ChatMessageData> msgs = [];

  void messagesHandle(List<ChatMessageData> data) {
    msgs = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: msgs.map(WChatMsgTile.new).toList(),
        ),
      );
}

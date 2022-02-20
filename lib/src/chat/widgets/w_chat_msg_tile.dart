import 'package:flutter/material.dart';

import '../chat_message_data.dart';

class WChatMsgTile extends StatelessWidget {
  const WChatMsgTile(this.data, {Key? key}) : super(key: key);

  final ChatMessageData data;

  @override
  Widget build(BuildContext context) => ListTile(
        trailing: Text(data.timestamp.toString()),
        title: Text(data.author.name),
        subtitle: Text(data.message),
      );
}

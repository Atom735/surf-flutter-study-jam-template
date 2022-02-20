import 'package:flutter/material.dart';

import '../chat_message_data.dart';

class WChatMsgTile extends StatelessWidget {
  const WChatMsgTile(this.data, {Key? key}) : super(key: key);

  final ChatMessageData data;

  @override
  Widget build(BuildContext context) {
    final firstLetter =
        data.author.name.isEmpty ? '?' : data.author.name.substring(0, 1);

    var color = Color(0xff000000 | firstLetter.hashCode);
    if (color.computeLuminance() < 0.4) {
      color = Color(0x00ffffff ^ color.value);
    }
    final color2 = color.computeLuminance() < 0.4 ? Colors.white : Colors.black;

    return ListTile(
      leading: CircleAvatar(
        foregroundColor: color2,
        backgroundColor: color,
        child: Text(
          firstLetter,
        ),
      ),
      trailing: Text(data.timestamp.toString()),
      title: Text(data.author.name),
      subtitle: Text(data.message),
      isThreeLine: data.message.contains('\n'),
    );
  }
}

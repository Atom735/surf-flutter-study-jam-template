import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/w_error_msgbox.dart';
import '../chat_message_data.dart';

class WChatMsgTile extends StatelessWidget {
  const WChatMsgTile(this.data, {Key? key}) : super(key: key);

  final ChatMessageData data;

  @override
  Widget build(BuildContext context) {
    final data = this.data;
    final firstLetter =
        data.author.name.isEmpty ? '?' : data.author.name.substring(0, 1);

    var color = Color(0xff000000 | firstLetter.hashCode);
    if (color.computeLuminance() < 0.4) {
      color = Color(0x00ffffff ^ color.value);
    }
    final color2 = color.computeLuminance() < 0.4 ? Colors.white : Colors.black;
    Widget result = Text(data.message);
    if (data is ChatMessageGeolocatedData) {
      result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    Поделился геолокацией',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              launch(
                  'https://www.google.ru/maps/@${data.location.latitude},${data.location.longitude},16z');
              // WErrorMsgBox.show(context, 'Открыть в картах', 'не реализовано');
            },
            icon: const Icon(Icons.location_on),
            label: Text('Открыть в картах'
                ' (${(data.location.latitude * 100).toInt() / 100}, '
                '${(data.location.longitude * 100).toInt() / 100})'),
          ),
          if (data.message.isNotEmpty) result,
        ],
      );
    }
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
      subtitle: result,
      isThreeLine: data.message.contains('\n'),
    );
  }
}

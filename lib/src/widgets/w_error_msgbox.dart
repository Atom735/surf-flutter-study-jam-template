import 'package:flutter/material.dart';

class WErrorMsgBox extends StatelessWidget {
  const WErrorMsgBox(this.title, this.msg, {Key? key}) : super(key: key);
  static Future<void> show(BuildContext context, String title, String msg) =>
      showDialog(
        context: context,
        builder: (context) => WErrorMsgBox(title, msg),
      );

  final String title;
  final String msg;
  @override
  Widget build(BuildContext context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Icon(
              Icons.warning,
              size: 32,
              color: Theme.of(context).errorColor,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
        children: [Text(msg)],
      );
}

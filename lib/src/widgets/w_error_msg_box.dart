import 'package:flutter/material.dart';

class WErrorMsgBox extends StatelessWidget {
  const WErrorMsgBox(this.title,
      {this.msg, Key? key, this.content, this.actions})
      : super(key: key);

  final String title;
  final String? msg;
  final Widget? content;
  final List<Widget>? actions;

  Future<T?> show<T>(BuildContext context) =>
      showDialog<T>(context: context, builder: build);

  @override
  Widget build(BuildContext context) {
    var content = this.content;
    if (msg != null) {
      content ??= Text(
        msg!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      );
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).errorColor,
      title: Row(
        children: [
          Icon(
            Icons.error,
            size: 32,
            color: Theme.of(context).colorScheme.onError,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onError,
            ),
            softWrap: true,
          ),
        ],
      ),
      content: content,
      actions: actions,
    );
  }
}

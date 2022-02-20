import 'package:flutter/material.dart';

import '../chat_repository_interface.dart';

class WChatScreen extends StatefulWidget {
  const WChatScreen(this.repo, {Key? key}) : super(key: key);

  final IChatRepository repo;

  @override
  State<WChatScreen> createState() => _WChatScreenState();
}

class _WChatScreenState extends State<WChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

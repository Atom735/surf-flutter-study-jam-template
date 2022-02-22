import 'package:flutter/material.dart';

import 'w_widgets_factory_mixin.dart';

class WChatListScreen extends StatefulWidget {
  const WChatListScreen({Key? key}) : super(key: key);

  @override
  State<WChatListScreen> createState() => _WChatListScreenState();
}

class _WChatListScreenState extends State<WChatListScreen>
    with WWidgetsFactoryMixin<WChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

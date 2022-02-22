import 'package:flutter/material.dart';

import 'w_widgets_factory_mixin.dart';

class WChatRoomScreen extends StatefulWidget {
  const WChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<WChatRoomScreen> createState() => _WChatRoomScreenState();
}

class _WChatRoomScreenState extends State<WChatRoomScreen>
    with WWidgetsFactoryMixin<WChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

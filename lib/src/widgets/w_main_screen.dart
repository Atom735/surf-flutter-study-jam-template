import 'package:flutter/material.dart';

import 'w_widgets_factory_mixin.dart';

class WMainScreen extends StatefulWidget {
  const WMainScreen({Key? key}) : super(key: key);

  @override
  State<WMainScreen> createState() => _WMainScreenState();
}

class _WMainScreenState extends State<WMainScreen>
    with WWidgetsFactoryMixin<WMainScreen> {
  Widget? layoutedWidgetCache;
  double width = 0;

  Widget layoutBuilder(BuildContext context, BoxConstraints constraints) {
    final widthNew = constraints.maxWidth;
    if (width != widthNew) {
      width = widthNew;
      layoutedWidgetCache = null;
    }
    return layoutedWidgetCache ??= Row(
      children: [
        Expanded(flex: 2, child: wfactory.buildChatListScreen(context)),
        Expanded(flex: 10, child: wfactory.buildChatRoomScreen(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: layoutBuilder);
}

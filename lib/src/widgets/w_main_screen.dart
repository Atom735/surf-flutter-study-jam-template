import 'package:flutter/material.dart';

import 'w_widgets_factory_mixin.dart';

class WMainScreen extends StatefulWidget {
  const WMainScreen({Key? key}) : super(key: key);

  @override
  State<WMainScreen> createState() => _WMainScreenState();
}

class _WMainScreenState extends State<WMainScreen>
    with WWidgetsFactoryMixin<WMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

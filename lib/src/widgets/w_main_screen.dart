import 'package:flutter/material.dart';

import '../interfaces/i_widgets_factory.dart';

class WMainScreen extends StatefulWidget {
  const WMainScreen(this.factory, {Key? key}) : super(key: key);

  final IWidgetsFactory factory;

  @override
  State<WMainScreen> createState() => _WMainScreenState();
}

class _WMainScreenState extends State<WMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

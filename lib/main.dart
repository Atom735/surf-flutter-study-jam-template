import 'package:flutter/widgets.dart';

import 'src/interfaces/i_widgets_factory.dart';
import 'src/widgets/widgets_factory.dart';

void main(List<String> args) {
  IWidgetsFactory.instance = WidgetsFactory();
  runApp(IWidgetsFactory.instance.rootWidget);
}

import 'package:flutter/widgets.dart';

import 'src/interfaces/i_widgets_factory.dart';
import 'src/widgets/widgets_factory_windows.dart';

void main(List<String> args) {
  IWidgetsFactory.instance = WidgetsFactoryWindows();
  runApp(IWidgetsFactory.instance.rootWidget);
}

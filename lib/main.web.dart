import 'package:flutter/widgets.dart';

import 'src/interfaces/i_widgets_factory.dart';
import 'src/widgets/widgets_factory_web.dart';

void main(List<String> args) {
  IWidgetsFactory.instance = WidgetsFactoryWeb();
  runApp(IWidgetsFactory.instance.rootWidget);
}

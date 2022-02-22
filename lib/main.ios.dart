import 'package:flutter/widgets.dart';

import 'src/interfaces/i_widgets_factory.dart';
import 'src/widgets/widgets_factory_ios.dart';

void main(List<String> args) {
  IWidgetsFactory.instance = WidgetsFactoryIos();
  runApp(IWidgetsFactory.instance.rootWidget);
}

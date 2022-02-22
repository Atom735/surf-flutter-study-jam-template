import 'package:flutter/widgets.dart';

import 'src/interfaces/i_widgets_factory.dart';
import 'src/widgets/widgets_factory_mock.dart';

void main(List<String> args) {
  IWidgetsFactory.instance = WidgetsFactoryMock();
  runApp(IWidgetsFactory.instance.rootWidget);
}

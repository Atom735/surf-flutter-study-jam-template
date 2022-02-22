import 'package:flutter/widgets.dart';

import '../interfaces/i_messenger.dart';
import '../interfaces/i_widgets_factory.dart';
import 'w_widgets_factory_provider.dart';

mixin WWidgetsFactoryMixin<T extends StatefulWidget> on State<T> {
  late IWidgetsFactory wfactory;
  IMessenger get messenger => wfactory.messenger;

  var _factoryGetted = false;

  /// Метод который вызывается, когда произошло получение [wfactory].
  /// По сути вызывается один после [initState] только
  /// внутри уже имеется доступ к [context].
  @mustCallSuper
  void onFactoryGetted() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final wfactoryNew = WWidgetFactoryProvider.of(context);
    if (!_factoryGetted) {
      _factoryGetted = true;
      wfactory = wfactoryNew;
      onFactoryGetted();
    } else if (wfactory != wfactoryNew) {
      throw Exception('WWidgetFactoryProvider не должен обновляться');
    }
  }
}

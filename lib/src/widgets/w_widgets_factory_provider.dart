import 'package:flutter/widgets.dart';

import '../interfaces/i_widgets_factory.dart';

/// Производит инъекцию [IWidgetsFactory] в остальные виджеты, чтобы можно
/// было им пользоваться оттуда, не передавая этот объект через аргумент
class WWidgetFactoryProvider extends InheritedWidget {
  const WWidgetFactoryProvider(this.factory, {required Widget child, Key? key})
      : super(key: key, child: child);

  static IWidgetsFactory of(BuildContext context) {
    final foundedWidget =
        context.dependOnInheritedWidgetOfExactType<WWidgetFactoryProvider>();
    assert(
        foundedWidget != null,
        'Вы забыли построить виджет WWidgetFactoryProvider выше по дереву,'
        ' либо вы обратились к контексту который выше провайдера');
    return foundedWidget!.factory;
  }

  final IWidgetsFactory factory;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is! WWidgetFactoryProvider || oldWidget.factory != factory;
}

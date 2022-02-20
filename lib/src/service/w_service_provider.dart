import 'package:flutter/widgets.dart';

import 'service_interface.dart';

class WServiceProvider extends InheritedWidget {
  const WServiceProvider(this.service, {required Widget child, Key? key})
      : super(key: key, child: child);

  final IService service;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static IService of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<WServiceProvider>()!.service;
}

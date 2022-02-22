import 'package:flutter/widgets.dart';

import '../common/l10n.dart';

mixin WWidgetsL10nMixin<T extends StatefulWidget> on State<T> {
  /// Объкт представляющий локализацию
  late S s;

  var _l10nGetted = false;

  /// Метод который вызывается, когда сменяется локаль. Также вызывается
  /// сразу после [initState], но уже с доступом к [context].
  @mustCallSuper
  void onL10nUpdated() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sNew = S.of(context);
    assert(sNew == null, 'Отсутсвует AppLocaliation выше по дереву');
    if (!_l10nGetted || s != sNew) {
      _l10nGetted = true;
      s = sNew!;
      onL10nUpdated();
    }
  }
}

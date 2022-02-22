import 'package:flutter/material.dart';

import '../common/l10n.dart';
import '../common/misc_flutter.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_widgets_factory.dart';
import 'w_error_msgbox.dart';

class WInitializingScreen extends StatefulWidget {
  const WInitializingScreen(this.factory, {Key? key}) : super(key: key);
  final IWidgetsFactory factory;
  @override
  State<WInitializingScreen> createState() => _WInitializingPageState();
}

class _WInitializingPageState extends State<WInitializingScreen> {
  IWidgetsFactory get factory => widget.factory;
  IMessenger get messenger => factory.messenger;

  bool initialized = false;
  Object? error;
  TextStyle? tsLarge;
  Widget? cachedBuild;
  S? s;

  void onInitEnd(_) {
    if (!mounted) return;
    initialized = true;
    updateState();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: factory.buildMainScreen),
    );
  }

  void onInitError(Object e) {
    if (!mounted) return;
    error = e;
    updateState();
    showDialog(
      context: context,
      builder: WErrorMsgBox(
        s!.app_loading_error,
        msg: e.toString(),
      ).build,
    ).then(handleRestart);
  }

  /// Опциональный параметр необходим для установки функции в Future.then
  void handleRestart([_]) {
    if (!mounted) return;
    initialized = false;
    messenger.init().then(onInitEnd, onError: onInitError);
    updateState();
  }

  @override
  void initState() {
    super.initState();
    handleRestart();
  }

  @override
  void dispose() {
    messenger.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tsLargeNew = Theme.of(context).typography.englishLike.displayLarge;
    if (tsLarge != tsLargeNew) {
      tsLarge = tsLargeNew;
      cachedBuild = null;
    }
    final ns = S.of(context);
    if (s != ns) {
      s = ns;
      cachedBuild = null;
    }
  }

  @override
  Widget build(BuildContext context) => cachedBuild ??= Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 128,
                    height: 128,
                    child: CircularProgressIndicator(strokeWidth: 8),
                  ),
                  Text(s!.app_loading, style: tsLarge!)
                ],
              ),
            ),
          ),
        ),
      );
}

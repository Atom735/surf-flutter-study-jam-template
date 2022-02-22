import 'package:flutter/material.dart';

import '../common/l10n.dart';
import '../common/misc_flutter.dart';
import 'w_error_msg_box.dart';
import 'w_widgets_factory_mixin.dart';

class WInitializingScreen extends StatefulWidget {
  const WInitializingScreen({Key? key}) : super(key: key);
  @override
  State<WInitializingScreen> createState() => _WInitializingPageState();
}

class _WInitializingPageState extends State<WInitializingScreen>
    with WWidgetsFactoryMixin<WInitializingScreen> {
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
      MaterialPageRoute(builder: wfactory.buildMainScreen),
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
    ).then(handleRestartInit);
  }

  void handleRestartInit([_]) {
    if (!mounted) return;
    initialized = false;
    messenger.init().then(onInitEnd, onError: onInitError);
    updateState();
  }

  @override
  void dispose() {
    messenger.dispose();
    super.dispose();
  }

  @override
  void onFactoryGetted() => handleRestartInit();

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

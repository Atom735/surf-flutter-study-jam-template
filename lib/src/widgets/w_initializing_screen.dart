import 'package:flutter/material.dart';

import '../common/misc_flutter.dart';
import 'w_error_msg_box.dart';
import 'w_widgets_factory_mixin.dart';
import 'w_widgets_l10n_mixin.dart';

class WInitializingScreen extends StatefulWidget {
  const WInitializingScreen({Key? key}) : super(key: key);
  @override
  State<WInitializingScreen> createState() => _WInitializingPageState();
}

class _WInitializingPageState extends State<WInitializingScreen>
    with
        WWidgetsFactoryMixin<WInitializingScreen>,
        WWidgetsL10nMixin<WInitializingScreen> {
  bool initialized = false;
  Object? error;
  TextStyle? tsLarge;
  Widget? cachedBuild;

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
        'ошибка загрузки',
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
  void onFactoryGetted() {
    super.onFactoryGetted();
    handleRestartInit();
  }

  @override
  void onL10nUpdated() {
    super.onL10nUpdated();
    cachedBuild = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tsLargeNew = Theme.of(context).typography.englishLike.displayLarge;
    if (tsLarge != tsLargeNew) {
      tsLarge = tsLargeNew;
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
                  Text('init....', style: tsLarge),
                ],
              ),
            ),
          ),
        ),
      );
}

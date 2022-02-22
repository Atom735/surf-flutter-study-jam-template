import 'package:flutter/material.dart';

import '../chat/widgets/w_chat_screen.dart';
import '../common/misc_flutter.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_widgets_factory.dart';
import '../service/service_interface.dart';
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
    WErrorMsgBox.show(
      context,
      'Ошибка при инициализации приложения',
      e.toString(),
    );
  }

  void handleRestart() {
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

  TextStyle? tsLarge;
  Widget? cachedBuild;

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
                  Text('Идёт загрузка', style: tsLarge)
                ],
              ),
            ),
          ),
        ),
      );
}

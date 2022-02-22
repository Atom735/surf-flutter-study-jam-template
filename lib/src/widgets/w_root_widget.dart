import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/misc_flutter.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_widgets_factory.dart';

class WRootWidget extends StatefulWidget {
  const WRootWidget(this.factory, {Key? key}) : super(key: key);

  final IWidgetsFactory factory;

  @override
  State<WRootWidget> createState() => _WRootWidgetState();
}

class _WRootWidgetState extends State<WRootWidget> {
  IWidgetsFactory get factory => widget.factory;
  IMessenger get messenger => factory.messenger;
  bool initialized = false;
  Object? error;

  void onInitEnd(_) {
    initialized = true;
    updateState();
  }

  void onInitError(Object e) {
    error = e;
    updateState();
  }

  void handleRestart() {
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
  Widget build(BuildContext context) {
    if (error == null) {
      if (initialized) {
        return factory.buildMainScreen(context);
      } else {
        return factory.buildSplashSreen(context);
      }
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: handleRestart,
        child: ColoredBox(
          color: const Color(0xFF7F0000),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 32,
                ),
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

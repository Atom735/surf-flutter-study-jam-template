import 'package:flutter/material.dart';

import '../chat/widgets/w_chat_screen.dart';
import '../service/service_interface.dart';

class WInitializingScreen extends StatefulWidget {
  const WInitializingScreen(this.service, {Key? key}) : super(key: key);
  final IService service;
  @override
  State<WInitializingScreen> createState() => _WInitializingPageState();
}

class _WInitializingPageState extends State<WInitializingScreen> {
  @override
  void initState() {
    super.initState();
    widget.service.initFuture.then(_onInit);
  }

  void _onInit(String? errorMsg) {
    if (errorMsg != null) {
      this.errorMsg = errorMsg;
      setState(() {});
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WChatScreen(widget.service),
      ),
    );
  }

  String? errorMsg;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: FittedBox(
              child: errorMsg != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error,
                          size: 128,
                          color: Theme.of(context).errorColor,
                        ),
                        Text(
                          'Ошибка: $errorMsg',
                          style: Theme.of(context)
                              .typography
                              .englishLike
                              .displayMedium
                              ?.copyWith(color: Theme.of(context).errorColor),
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 128,
                          height: 128,
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                          ),
                        ),
                        Text(
                          'Идёт загрузка',
                          style: Theme.of(context)
                              .typography
                              .englishLike
                              .displayLarge,
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
}

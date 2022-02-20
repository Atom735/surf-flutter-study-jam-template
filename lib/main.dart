import 'package:flutter/material.dart';

import 'src/service/service_windows_imp.dart';
import 'src/service/w_service_provider.dart';
import 'src/widgets/w_app.dart';

void main() {
  final service = ServiceWindowsImpl();
  runApp(WServiceProvider(service, child: const WApp()));

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform(
  //     androidKey: 'AIzaSyCXU5f25S_SUeVv7cAzoeF373kHk4Hv2dE',
  //     iosKey: 'AIzaSyAjvNoe31ZMSakjKFOkhbrZBsj3RyW6plo',
  //     webKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
  //     windowsKey: 'AIzaSyD40PR_fizjSYtCZEtXgwq_5LdJu2w2zIs',
  //   ),
  // );
}

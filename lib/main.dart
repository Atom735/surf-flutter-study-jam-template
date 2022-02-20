import 'package:flutter/material.dart';

import 'src/service/service_windows_imp.dart';
import 'src/service/w_service_provider.dart';
import 'src/widgets/w_app.dart';

void main() {
  final service = ServiceWindowsImpl();
  runApp(WServiceProvider(service, child: const WApp()));
}

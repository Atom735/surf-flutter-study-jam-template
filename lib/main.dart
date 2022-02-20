import 'package:flutter/material.dart';

import 'src/service/service_web_imp.dart';
import 'src/service/w_service_provider.dart';
import 'src/widgets/w_app.dart';

void main() {
  final service = ServiceWebImpl();
  runApp(WServiceProvider(service, child: const WApp()));
}

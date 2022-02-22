import 'package:flutter/widgets.dart';

extension StateX<T extends StatefulWidget> on State<T> {
  // ignore: invalid_use_of_protected_member
  void updateState() => setState(kVoidFunc);
}

void kVoidFunc() {}

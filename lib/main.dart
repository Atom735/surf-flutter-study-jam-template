import 'package:flutter/material.dart';

import 'src/service/service_web_imp.dart';
import 'src/service/w_service_provider.dart';
import 'src/widgets/w_app.dart';

void main() {
  final service = ServiceWebImpl();
  runApp(WServiceProvider(service, child: const WApp()));
}

class MyWidget extends StatefulWidget {
  const MyWidget(this.index, {this.cached = false, Key? key}) : super(key: key);

  final bool cached;
  final int index;

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int get index => widget.index;
  bool get cached => widget.cached;
  @override
  void initState() {
    super.initState();
    print('$this($cached  $index): Created');
  }

  @override
  Widget build(BuildContext context) {
    print('$this($cached $index): Rebuilded');
    return ListTile(title: Text('$index'));
  }
}

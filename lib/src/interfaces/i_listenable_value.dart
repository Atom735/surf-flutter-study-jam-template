import '_i_listenable_stub.dart'
    if (dart.library.ui) '_i_listenable_with_flutter.dart';
import 'i_disposible.dart';

abstract class IListenableValue<T> implements IDisposible, IListenable {
  T get value;

  @override
  void addListener(void Function() listener);

  @override
  void removeListener(void Function() listener);
}

abstract class IListenable {
  void addListener(void Function() listener);

  void removeListener(void Function() listener);
}

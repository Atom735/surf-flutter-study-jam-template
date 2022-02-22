import 'dart:math';

void main(List<String> args) {
  final rand = Random(DateTime.now().microsecondsSinceEpoch);
  final a = List<int>.generate(2000000, (index) => rand.nextInt(1000000));
  final out = <int>[];
  for (var i = 0; i < a.length; i++) {
    final v = a[i];
    var k = i - 1;
    while (k > 0 && a[k] < v) {
      k--;
    }
    if (k >= 0) {
      if (out[k] == v) {
        out.removeAt(k);
      } else {
        out.insert(k, v);
      }
    } else {
      out.add(v);
    }
  }
  print(out);
}

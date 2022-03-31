import 'package:meta/meta.dart';

import 'random_gen.dart';

@immutable
class MockException implements Exception {
  @literal
  const MockException(this.message);

  final String message;

  @override
  String toString() => 'MockException: $message';
}

class Mock {
  Mock({
    this.mockDelayMin = const Duration(milliseconds: 50),
    this.mockDelayAdd = const Duration(milliseconds: 333),
    this.mockThrowsChance = 0.0,
  });
  Mock.copy(Mock? v)
      : this(
          mockDelayAdd: v?.mockDelayAdd ?? _def.mockDelayAdd,
          mockDelayMin: v?.mockDelayMin ?? _def.mockDelayMin,
          mockThrowsChance: v?.mockThrowsChance ?? _def.mockThrowsChance,
        );

  static final _def = Mock();

  /// Рандомизатор
  final mockRandom = RandomGen(DateTime.now().microsecondsSinceEpoch);

  /// Минимальные задержки
  final Duration mockDelayMin;

  /// Случайно добавляемая задержка
  final Duration mockDelayAdd;

  /// Шанс выпадения ошибки от 0 до 1.0
  double mockThrowsChance;

  void mockThrows(String message) {
    if (mockRandom.nextDouble() < mockThrowsChance) {
      throw MockException(message);
    }
  }

  Future mockDelayed(double factor) => Future.delayed(
      mockDelayMin + mockDelayAdd * (mockRandom.nextDouble() * factor));
}

import 'package:meta/meta.dart';

@immutable
class InvalidNameException implements Exception {
  const InvalidNameException(this.message);

  final String message;

  @override
  String toString() => 'InvalidNameException(message: $message)';
}

@immutable
class InvalidMessageException implements Exception {
  const InvalidMessageException(this.message);

  final String message;

  @override
  String toString() => 'InvalidMessageException(message: $message)';
}

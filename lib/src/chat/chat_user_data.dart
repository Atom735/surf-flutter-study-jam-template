import 'package:meta/meta.dart';

/// Basic model representing chat user.
@immutable
class ChatUserData {
  const ChatUserData(this.name);
  final String name;

  @override
  String toString() => 'ChatUserData(name: $name)';
}

/// Model representing local user.
///
/// As rule as user with the same nickname was entered when sending a message
/// from this device.
@immutable
class ChatUserLocalData extends ChatUserData {
  const ChatUserLocalData(String name) : super(name);

  @override
  String toString() => 'ChatUserLocalData(name: $name)';
}

import 'package:meta/meta.dart';

import '../common/geolocation_data.dart';
import '../common/types.dart';
import 'chat_user_data.dart';

@immutable
class ChatMessageData {
  ChatMessageData(this.author, this.message) : timestamp = TimeStamp.now();
  ChatMessageData.copy(ChatMessageData msg)
      : this.full(msg.timestamp, msg.author, msg.message);
  const ChatMessageData.full(this.timestamp, this.author, this.message);

  /// Creation date and time.
  final TimeStamp timestamp;

  /// Message author.
  final ChatUserData author;

  /// Chat message string.
  final String message;

  @override
  String toString() => 'ChatMessageData('
      'timestamp: $timestamp, '
      'author: $author, '
      'message: $message)';
}

@immutable
class ChatMessageGeolocatedData extends ChatMessageData {
  ChatMessageGeolocatedData(ChatUserData author, String message, this.location)
      : super(author, message);
  ChatMessageGeolocatedData.locationOnly(ChatUserData author, this.location)
      : super(author, '');
  ChatMessageGeolocatedData.copy(ChatMessageData msg, this.location)
      : super.copy(msg);
  const ChatMessageGeolocatedData.full(
      TimeStamp timestamp, ChatUserData author, String message, this.location)
      : super.full(timestamp, author, message);

  /// Location point.
  final GeolocationData location;

  @override
  String toString() => 'ChatMessageGeolocatedData('
      'timestamp: $timestamp, '
      'author: $author, '
      'location: $location, '
      'message: $message)';
}

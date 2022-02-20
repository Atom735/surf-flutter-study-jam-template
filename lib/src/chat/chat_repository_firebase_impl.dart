import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../common/geolocation_data.dart';
import '../common/types.dart';
import 'chat_message_data.dart';
import 'chat_repository_exceptions.dart';
import 'chat_repository_interface.dart';
import 'chat_user_data.dart';

class ChatRepositoryFirebaseImpl implements IChatRepository {
  ChatRepositoryFirebaseImpl(this._firebaseClient);

  static const String _messagesCollectionKey = 'messages';

  final FirebaseFirestore _firebaseClient;

  var _savedLocalName = '';

  @override
  Future<List<ChatMessageData>> getMessages(int limit,
      [TimeStamp? lastTimeStamp]) async {
    await Future.delayed(const Duration(seconds: 1));
    if (lastTimeStamp == null) {
      return (await _firebaseClient
              .collection(_messagesCollectionKey)
              .limit(limit)
              .orderBy('created', descending: true)
              .get())
          .docs
          .map(_parseFirebaseDataToLocal)
          .toList();
    } else {
      return (await _firebaseClient
              .collection(_messagesCollectionKey)
              .limit(limit)
              .where('created',
                  isGreaterThanOrEqualTo: Timestamp.fromDate(lastTimeStamp))
              .orderBy('created', descending: true)
              .get())
          .docs
          .map(_parseFirebaseDataToLocal)
          .toList();
    }
  }

  @override
  Future<void> sendMessage(ChatMessageData data) async {
    final username = data.author.name;
    final message = data.message;
    _validateName(username);
    if (!(data is ChatMessageGeolocatedData && message.isEmpty)) {
      _validateMessage(message);
    }

    _savedLocalName = username;
    await Future.delayed(const Duration(seconds: 1));

    await _firebaseClient.collection(_messagesCollectionKey).add({
      MessageFirebaseDto._authorNameKey: username,
      MessageFirebaseDto._messageKey: message,
      MessageFirebaseDto._createdKey: FieldValue.serverTimestamp(),
      if (data is ChatMessageGeolocatedData)
        MessageFirebaseDto._geolocationKey: GeoPoint(
          data.location.latitude,
          data.location.longitude,
        ),
    });
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      throw const InvalidNameException('Name cannot be empty!');
    }

    if (name.length > IChatRepository.maxNameLength) {
      throw const InvalidNameException('Name cannot contain more than '
          '${IChatRepository.maxNameLength} symbols');
    }
  }

  void _validateMessage(String message) {
    if (message.isEmpty) {
      throw const InvalidMessageException('Message cannot be empty!');
    }

    if (message.length > IChatRepository.maxMessageLength) {
      throw const InvalidNameException('Message cannot contain more than '
          '${IChatRepository.maxMessageLength} symbols');
    }
  }

  ChatMessageData _parseFirebaseDataToLocal(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final parsedData = MessageFirebaseDto.fromMap(snapshot.data());

    final ChatUserData author;
    if (parsedData.authorName == _savedLocalName) {
      author = ChatUserLocalData(parsedData.authorName);
    } else {
      author = ChatUserData(parsedData.authorName);
    }

    final geolocation = parsedData.geolocation;
    if (geolocation != null) {
      return ChatMessageGeolocatedData.full(
        parsedData.created,
        author,
        parsedData.message,
        GeolocationData(geolocation.latitude, geolocation.longitude),
      );
    }

    return ChatMessageData.full(
      parsedData.created,
      author,
      parsedData.message,
    );
  }
}

@immutable
class MessageFirebaseDto {
  const MessageFirebaseDto({
    required this.authorName,
    required this.message,
    required this.created,
    required this.geolocation,
  });

  MessageFirebaseDto.fromMap(Map<String, dynamic> map)
      : this(
          authorName: map[_authorNameKey] ?? '',
          message: map[_messageKey] ?? '',
          created: (map[_createdKey] as Timestamp).toDate(),
          geolocation: map[_geolocationKey],
        );

  Map<String, dynamic> toMap() => {
        _authorNameKey: authorName,
        _messageKey: message,
        _createdKey: created.millisecondsSinceEpoch,
      };

  static const String _authorNameKey = 'authorName';
  static const String _messageKey = 'message';
  static const String _createdKey = 'created';
  static const String _geolocationKey = 'geolocation';

  final String authorName;
  final String message;
  final DateTime created;
  final GeoPoint? geolocation;

  @override
  String toString() => '_MessageFirebaseDto('
      'authorName: $authorName, '
      'message: $message, '
      'created: $created, '
      'geolocation: $geolocation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageFirebaseDto &&
        other.authorName == authorName &&
        other.message == message &&
        other.created == created;
  }

  @override
  int get hashCode => authorName.hashCode ^ message.hashCode ^ created.hashCode;

  MessageFirebaseDto copyWith({
    String? authorName,
    String? message,
    DateTime? created,
    GeoPoint? geolocation,
  }) =>
      MessageFirebaseDto(
        authorName: authorName ?? this.authorName,
        message: message ?? this.message,
        created: created ?? this.created,
        geolocation: geolocation ?? this.geolocation,
      );
}

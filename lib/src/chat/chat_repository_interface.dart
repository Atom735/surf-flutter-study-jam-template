import 'chat_message_data.dart';

/// Chat data holder.
///
/// The only tool needed to implement the chat.
abstract class IChatRepository {
  static const int maxNameLength = 40;
  static const int maxMessageLength = 80;

  Future<List<ChatMessageData>> get messages;
  Future<List<ChatMessageData>> sendMessage(ChatMessageData data);
}

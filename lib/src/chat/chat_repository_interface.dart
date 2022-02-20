import '../common/types.dart';
import 'chat_message_data.dart';

/// Chat data holder.
///
/// The only tool needed to implement the chat.
abstract class IChatRepository {
  static const int maxNameLength = 40;
  static const int maxMessageLength = 80;

  Future<List<ChatMessageData>> getMessages(int limit,
      [TimeStamp? lastTimeStamp]);
  Future<void> sendMessage(ChatMessageData data);
}

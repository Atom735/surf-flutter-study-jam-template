import 'package:shared_preferences/shared_preferences.dart';

import '../chat/chat_message_data.dart';
import '../chat/chat_repository_interface.dart';

abstract class IService {
  Future<String?> get initFuture;
  IChatRepository get chatRepo;
  SharedPreferences get sp;
  void dispose();

  String get userName;
  set userName(String userName);

  Future<List<ChatMessageData>> getMessages();
  Future<void> sendMessage(ChatMessageData data);
}

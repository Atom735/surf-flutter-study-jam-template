import '../chat/chat_repository_interface.dart';

abstract class IService {
  Future<String?> get initFuture;
  IChatRepository get chatRepo;
  void dispose();
}

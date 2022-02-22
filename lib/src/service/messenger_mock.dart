import '../interfaces/i_chat_room.dart';
import '../interfaces/i_account.dart';
import '../interfaces/i_chat_rooms_list.dart';
import '../interfaces/i_messenger.dart';

class MessengerMock implements IMessenger {
  @override
  String get version => 'Atmos chat [1.0.1+1](Windows)';

  @override
  MessengerStatus status = MessengerStatus.created;

  @override
  Future init() async {
    assert(
        status == MessengerStatus.created || status == MessengerStatus.errored,
        'Уже инициализированно');
    status = MessengerStatus.initializing;
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  IAccount get account => const AccountUnimplemented();

  @override
  IChatRoomsList get chats => const ChatRoomsListUnimplemented();

  @override
  IChatRoom createNewChatRoom() => const ChatRoomUnimplemented();

  @override
  bool get isDisposed => status == MessengerStatus.disposed;

  @override
  Future dispose() async {
    assert(!isDisposed, 'Уже освобождены ресурсы');
  }
}

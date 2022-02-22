import '../common/mock.dart';
import '../interfaces/i_account.dart';
import '../interfaces/i_chat_room.dart';
import '../interfaces/i_chat_rooms_list.dart';
import '../interfaces/i_messenger.dart';

class MessengerMock extends Mock implements IMessenger {
  MessengerMock({Mock? mock}) : super.copy(mock);

  @override
  String get version => 'Atmos chat [1.0.1+1](Windows)';

  @override
  MessengerStatus status = MessengerStatus.created;

  @override
  Future init() async {
    assert(
        status == MessengerStatus.created || status == MessengerStatus.errored,
        'Уже инициализированно');
    try {
      status = MessengerStatus.initializing;
      await mockDelayed(0.15);
      mockThrows('Невозможно обнаружить ресурсы');
      await mockDelayed(0.5);
      mockThrows('База данных повреждена');
    } on Object {
      status = MessengerStatus.errored;
      rethrow;
    }
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

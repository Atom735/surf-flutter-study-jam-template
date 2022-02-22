import 'i_account.dart';
import 'i_chat_room.dart';
import 'i_chat_rooms_list.dart';
import 'i_disposible.dart';

/// Интрфейс мессенджера. Через него происходит всё управление приложением.
abstract class IMessenger implements IDisposible {
  /// Версия мессенджера
  String get version;

  /// Статус мессенджера
  MessengerStatus get status;

  /// Возвращает фьючу которая уведомляет о конце инициализации
  /// (Повторный вызов ращрешён, только когда предыдущая фьюча завершилась с
  /// ошибкой)
  Future init();

  /// Аккаунт вошедшего пользователя
  IAccount get account;

  /// Список всех чатов
  IChatRoomsList get chats;

  /// Создание нового чата
  /// (Не должен происходить повторный вызов этой функции пока не завершится
  /// предыдущий вызов)
  IChatRoom createNewChatRoom();
}

/// Состояние мессенджера
enum MessengerStatus {
  /// Создан
  created,

  /// Ошибка, не позволяющая дальнейшую работу
  errored,

  /// В процессе инициализации
  initializing,

  /// Ресурсы освобождены, приложение закрыто
  disposed,
}

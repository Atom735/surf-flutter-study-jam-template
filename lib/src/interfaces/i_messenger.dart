import 'i_account.dart';
import 'i_chat_room.dart';
import 'i_disposible.dart';

abstract class IMessenger implements IDisposible {
  /// Версия мессенджера
  String get version;

  /// Возвращает фьючу которая уведомляет о конце инициализации
  /// (Повторный вызов ращрешён, только когда предыдущая фьюча завершилась с
  /// ошибкой)
  Future init();

  /// Аккаунт вошедшего пользователя
  IAccount get account;

  /// Создание нового чата
  /// (Не должен происходить повторный вызов этой функции пока не завершится
  /// предыдущий вызов)
  Future<IChatRoom> createNewChatRoom();

  /// Получает список чатов
  Future<List<IChatRoom>> getChats();
}

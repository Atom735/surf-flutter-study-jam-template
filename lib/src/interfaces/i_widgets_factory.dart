import 'package:flutter/cupertino.dart';

import 'i_chat_room.dart';
import 'i_messenger.dart';
import 'i_user.dart';

/// Фабрика виджетов приложения
abstract class IWidgetsFactory {
  /// Интерфейс приложения
  IMessenger get messenger;

  /// Создаёт экран загрузки приложения
  Widget buildSplashSreen(BuildContext context);

  /// Создаёт экран авторизации
  Widget buildAuthSreen(BuildContext context);

  /// Создаёт главный отображаемый экран
  Widget buildMainScreen(BuildContext context);

  /// Создаёт виджет домашнего экрана
  Widget buildMenu(BuildContext context);

  /// Создаёт виджет экрана пользователя
  Widget buildUserScreen(BuildContext context, UserId id);

  /// Создаёт виджет выбора чата
  Widget buildChatListScreen(BuildContext context);

  /// Создаёт виджет чата
  Widget buildChatRoomScreen(BuildContext context, ChatRoomId id);
}

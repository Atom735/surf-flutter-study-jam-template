import 'package:flutter/cupertino.dart';

import 'i_chat_room.dart';
import 'i_messenger.dart';
import 'i_user.dart';

/// Интерфейс представляющий набор методов и функций для построения виджетов.
/// А также предоставляет доступ к интерфейсу [IMessenger].
///
/// Планируется под каждую платформу иметь свои экземпляры, которые будут
/// иметь свои собственные реализации [IMessenger], из за чего будет происходить
/// разделение зависимых пакетов от метода сборки.
///
/// Например под веб можно и нужно будет реализовать ленивую загрузку пакетов
/// https://dart.dev/guides/language/language-tour#:~:text=Lazily%20loading%20a%20library
abstract class IWidgetsFactory {
  /// Инстанс который должен заполнится в main.dart
  static late IWidgetsFactory instance;

  /// Интерфейс приложения
  IMessenger get messenger;

  /// Создание корневого виджета
  Widget get rootWidget;

  /// Показывает сообщение об ошибке
  /// - [title] Заголовок (Тип ошибки)
  /// - [msg] Сообщение об ошибке (Не используется если задан [content])
  /// - [content] Кастомный виджет отображаемый в диалоге (Не обязательно)
  /// - [actions] Список кнопок выплывающего бокса
  Future<T?> showErrorMsgBox<T>(
    BuildContext context,
    String title, {
    String? msg,
    Widget? content,
    List<Widget>? actions,
  });

  /// Показывает информаци о пользователе
  Future<T?> showUserInfo<T>(BuildContext context, UserId userId);

  /// Показывает информаци о чат комнате
  Future<T?> showChatRoomInfo<T>(BuildContext context, ChatRoomId userId);

  /// Создаёт экран загрузки приложения
  Widget buildInitializingSreen(BuildContext context);

  /// Создаёт экран авторизации
  Widget buildAuthSreen(BuildContext context);

  /// Создаёт главный отображаемый экран
  Widget buildMainScreen(BuildContext context);

  /// Создаёт экран выбора чата
  Widget buildChatListScreen(BuildContext context);

  /// Создаёт экран чат комнаты
  Widget buildChatRoomScreen(BuildContext context);

  /// Создаёт виджет домашнего экрана
  Widget buildMenu(BuildContext context);
}

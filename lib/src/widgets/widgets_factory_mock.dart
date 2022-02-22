import 'package:flutter/widgets.dart';

import '../interfaces/i_chat_room.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_user.dart';
import '../interfaces/i_widgets_factory.dart';
import '../service/messenger_mock.dart';
import 'w_app.dart';
import 'w_chat_list_screen.dart';
import 'w_chat_room_screen.dart';
import 'w_error_msg_box.dart';
import 'w_initializing_screen.dart';
import 'w_main_screen.dart';
import 'w_widgets_factory_provider.dart';

class WidgetsFactoryMock implements IWidgetsFactory {
  @override
  final IMessenger messenger = MessengerMock();

  @override
  Widget get rootWidget => WWidgetFactoryProvider(this, child: const WApp());

  @override
  Future<T?> showErrorMsgBox<T>(
    BuildContext context,
    String title, {
    String? msg,
    Widget? content,
    List<Widget>? actions,
  }) =>
      WErrorMsgBox(
        title,
        msg: msg,
        content: content,
        actions: actions,
      ).show<T>(context);

  @override
  Future<T?> showChatRoomInfo<T>(BuildContext context, ChatRoomId userId) =>
      throw UnimplementedError();

  @override
  Future<T?> showUserInfo<T>(BuildContext context, UserId userId) =>
      throw UnimplementedError();

  @override
  Widget buildInitializingSreen(BuildContext context) =>
      const WInitializingScreen();

  @override
  Widget buildMenu(BuildContext context) => const Placeholder();

  @override
  Widget buildAuthSreen(BuildContext context) => const Placeholder();

  @override
  Widget buildMainScreen(BuildContext context) => const WMainScreen();

  @override
  Widget buildChatListScreen(BuildContext context) => const WChatListScreen();

  @override
  Widget buildChatRoomScreen(BuildContext context) => const WChatRoomScreen();
}

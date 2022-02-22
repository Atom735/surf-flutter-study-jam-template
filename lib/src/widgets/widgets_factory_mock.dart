import 'package:flutter/widgets.dart';

import '../interfaces/i_chat_room.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_user.dart';
import '../interfaces/i_widgets_factory.dart';
import '../service/messenger_mock.dart';
import 'w_app.dart';
import 'w_error_msg_box.dart';
import 'w_initializing_screen.dart';
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
  Widget buildInitializingSreen(BuildContext context) =>
      const WInitializingScreen();

  @override
  Widget buildAuthSreen(BuildContext context) => throw UnimplementedError();

  @override
  Widget buildMainScreen(BuildContext context) => throw UnimplementedError();

  @override
  Widget buildMenu(BuildContext context) => throw UnimplementedError();

  @override
  Widget buildUserScreen(BuildContext context, UserId id) =>
      throw UnimplementedError();

  @override
  Widget buildChatListScreen(BuildContext context) =>
      throw UnimplementedError();

  @override
  Widget buildChatRoomScreen(BuildContext context, ChatRoomId id) =>
      throw UnimplementedError();
}

import 'package:flutter/widgets.dart';

import '../interfaces/i_chat_room.dart';
import '../interfaces/i_messenger.dart';
import '../interfaces/i_user.dart';
import '../interfaces/i_widgets_factory.dart';

class WidgetsFactoryIos implements IWidgetsFactory {
  @override
  Widget buildAuthSreen(BuildContext context) {
    // TODO: implement buildAuthSreen
    throw UnimplementedError();
  }

  @override
  Widget buildChatListScreen(BuildContext context) {
    // TODO: implement buildChatListScreen
    throw UnimplementedError();
  }

  @override
  Widget buildChatRoomScreen(BuildContext context, ChatRoomId id) {
    // TODO: implement buildChatRoomScreen
    throw UnimplementedError();
  }

  @override
  Widget buildMainScreen(BuildContext context) {
    // TODO: implement buildMainScreen
    throw UnimplementedError();
  }

  @override
  Widget buildMenu(BuildContext context) {
    // TODO: implement buildMenu
    throw UnimplementedError();
  }

  @override
  Widget buildSplashSreen(BuildContext context) {
    // TODO: implement buildSplashSreen
    throw UnimplementedError();
  }

  @override
  Widget buildUserScreen(BuildContext context, UserId id) {
    // TODO: implement buildUserScreen
    throw UnimplementedError();
  }

  @override
  // TODO: implement messenger
  IMessenger get messenger => throw UnimplementedError();

  @override
  // TODO: implement rootWidget
  Widget get rootWidget => throw UnimplementedError();
}

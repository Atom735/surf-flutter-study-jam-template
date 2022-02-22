import 'package:meta/meta.dart';

import 'i_disposible.dart';

abstract class IChatRoomsList implements IDisposible {}

@immutable
class ChatRoomsListUnimplemented implements IChatRoomsList {
  @literal
  const ChatRoomsListUnimplemented();
  @override
  bool get isDisposed => throw UnimplementedError();
  @override
  Future dispose() => throw UnimplementedError();
}

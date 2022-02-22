import 'package:meta/meta.dart';

import 'i_disposible.dart';
import 'i_id.dart';
import 'i_user.dart';

abstract class IChatRoom implements IDisposible {
  /// Айди чата.
  ChatRoomId get id;

  /// Пользователи связанные с этой комнатой и их никнеймы в этой комнате.
  /// В случае отсутсвия, отображается их Имя.
  Future<Map<IUser, String?>> get users;
}

@immutable
class ChatRoomId implements IId<IChatRoom, int> {
  @literal
  const ChatRoomId(this.value);

  /// Неизвестный айди чата, используется в момент создания нового чата.
  /// После его создания, возвращается настоящий айди.
  static const unknown = ChatRoomId(0);

  @override
  final int value;
}

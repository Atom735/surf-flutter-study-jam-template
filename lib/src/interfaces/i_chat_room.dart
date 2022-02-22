import 'package:meta/meta.dart';

import 'i_disposible.dart';
import 'i_id.dart';
import 'i_user.dart';

abstract class IChatRoom implements IDisposible {
  /// Пользователи связанные с этой комнатой и их никнеймы в этой комнате
  /// В случае отсутсвия, отображается их Имя
  Future<Map<IUser, String?>> get users;

  ///
  bool get initialized;
}

@immutable
class ChatRoomId implements IId<IChatRoom, int> {
  @literal
  const ChatRoomId(this.id);

  /// Неизвестный айди чата, используется в момент создания нового чата
  /// После его создания, возвращается настоящий айди
  static const unknown = ChatRoomId(0);

  @override
  final int id;
}

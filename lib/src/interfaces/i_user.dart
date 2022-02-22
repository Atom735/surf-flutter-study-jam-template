import 'package:meta/meta.dart';

import 'i_chat_room.dart';
import 'i_id.dart';

abstract class IUser {
  UserId get id;

  /// Имя пользователя.
  String get firstName;

  /// Фамилия пользователя. При отсутсвии является пустой строкой.
  String get lastName;

  /// Уникальное имя пользовтеля.
  /// Только латинские буквы, числа, и символы тире и нижние подчёркивания.
  /// Должен начинаться с буквы. (Если начинается с цифры, значит это значение
  /// установленное по умолчанию и является репрезентацие его [id])
  String get userName;

  /// Номер телефона пользователя.
  /// - Значение `null` означает что пользователь предпочёл скрыть эти данные.
  String? get phoneNumber;

  /// Последняя активность пользователя по UTC.
  /// - Значение `null` означает что пользователь предпочёл скрыть эти данные.
  DateTime? get lastActivity;

  /// Открывает личный чат с пользователем
  IChatRoom openChatWithUser();
}

@immutable
class UserId implements IId<IUser, int> {
  @literal
  const UserId(this.value);

  /// Неизвестный айди пользователя, используется в момент регистрации нового
  /// пользователя. После его создания, возвращается настоящий айди.
  static const unknown = UserId(0);

  @override
  final int value;
}

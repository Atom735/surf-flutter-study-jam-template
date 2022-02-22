import 'package:meta/meta.dart';

import 'i_user.dart';

abstract class IAccount {
  IUser get user;
}

@immutable
class AccountUnimplemented implements IAccount {
  @literal
  const AccountUnimplemented();

  @override
  IUser get user => throw UnimplementedError();
}

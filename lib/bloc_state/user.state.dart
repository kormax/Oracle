import 'package:data/entities/user.dart';

class UserState {
  User user;

  UserState(this.user);

  factory UserState.initial() => UserState(null);
}
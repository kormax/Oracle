import 'package:data/entities/user_token.dart';

class UserTokenState {
  UserToken token;

  UserTokenState(this.token);

  factory UserTokenState.initial() => UserTokenState(null);
}
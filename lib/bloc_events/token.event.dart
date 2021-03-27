import 'package:data/entities/user_token.dart';

abstract class TokenEvent {
  UserToken value;

  TokenEvent(this.value);
}

class SetToken extends TokenEvent {
  SetToken(UserToken value) : super(value);
}
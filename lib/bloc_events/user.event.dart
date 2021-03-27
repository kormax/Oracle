import 'package:data/entities/user.dart';

abstract class UserEvent {
  User value;

  UserEvent(this.value);
}

class SetUser extends UserEvent {
  SetUser(User value) : super(value);
}
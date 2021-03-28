import 'package:bloc/bloc.dart';
import 'package:data/bloc_events/user.event.dart';
import 'package:data/bloc_state/user.state.dart';
import 'package:data/entities/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({User user}) : super(user != null ? UserState(user) : UserState.initial());

  void onSetUser(User user) {
    print(user.email);
    print(user.id);

    add(SetUser(user));
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SetUser) {
      state.user = event.value;

      print('mapEventToState');
      print(state.user.email);
    }

    yield UserState(state.user);
  }
}

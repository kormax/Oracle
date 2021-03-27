import 'package:bloc/bloc.dart';
import 'package:data/bloc_events/token.event.dart';
import 'package:data/bloc_state/user_token.state.dart';
import 'package:data/entities/user_token.dart';

class TokenBloc extends Bloc<TokenEvent, UserTokenState> {
  TokenBloc() : super(UserTokenState.initial());

  void onSetToken(UserToken token) {
    print(token.access);

    add(SetToken(token));
  }

  @override
  Stream<UserTokenState> mapEventToState(TokenEvent event) async* {
    if (event is SetToken) {
      state.token = event.value;
    }

    yield UserTokenState(state.token);
  }
}
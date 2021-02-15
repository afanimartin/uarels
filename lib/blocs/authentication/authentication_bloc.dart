import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription _userStreamSubscription;

  AuthenticationBloc({AuthenticationRepository authenticationRepository})
      : _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository(),
        super(AuthenticationState.unknown()) {
    _userStreamSubscription?.cancel();

    _userStreamSubscription = _authenticationRepository.user
        .listen((user) => add(AuthenticationUserChanged(user: user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogOutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
          AuthenticationUserChanged event) =>
      event.user == UserModel.empty
          ? AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(event.user);
}

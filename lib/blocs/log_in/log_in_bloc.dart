import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/repositories.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthenticationRepository _authenticationRepository;

  LogInCubit({@required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LogInState());

  void logInWithGoogle() {
    _authenticationRepository.logInWithGoogleAccount();
  }

  void logOut() {
    _authenticationRepository.logOut();
  }
}

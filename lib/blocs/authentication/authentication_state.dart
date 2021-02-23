import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/user/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}
class Authenticated extends AuthenticationState {
  final UserModel user;

  const Authenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class UnAuthenticated extends AuthenticationState {}

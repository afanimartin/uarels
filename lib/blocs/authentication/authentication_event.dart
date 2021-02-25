import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationUserChanged extends AuthenticationEvent {
  final UserModel user;

  AuthenticationUserChanged({@required this.user});

  @override
  List<Object> get props => [user];
}

class LogUserOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

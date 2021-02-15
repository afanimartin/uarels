import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final UserModel user;

  const AuthenticationUserChanged({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationLogOutRequested extends AuthenticationEvent {}

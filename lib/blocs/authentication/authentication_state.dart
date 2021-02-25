import 'package:equatable/equatable.dart';

import '../../models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final UserModel user;
  final AuthenticationStatus status;

  const AuthenticationState(
      {this.user = UserModel.empty,
      this.status = AuthenticationStatus.unknown});

  factory AuthenticationState.authenticated(UserModel user) =>
      AuthenticationState(
          user: user, status: AuthenticationStatus.authenticated);

  factory AuthenticationState.unauthenticated() =>
      const AuthenticationState(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [user, status];
}

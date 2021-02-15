import 'package:equatable/equatable.dart';
import 'package:uarels/models/user/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.user = UserModel.empty});

  static AuthenticationState authenticated(UserModel user) =>
      AuthenticationState(
          status: AuthenticationStatus.authenticated, user: user);

  @override
  List<Object> get props => [];
}

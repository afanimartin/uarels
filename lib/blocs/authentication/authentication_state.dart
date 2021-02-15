import 'package:equatable/equatable.dart';
import '../../models/user/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.user = UserModel.empty});

  factory AuthenticationState.unknown() => const AuthenticationState();

  factory AuthenticationState.authenticated(UserModel user) =>
      AuthenticationState(
          status: AuthenticationStatus.authenticated, user: user);

  factory AuthenticationState.unauthenticated() =>
      const AuthenticationState(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}

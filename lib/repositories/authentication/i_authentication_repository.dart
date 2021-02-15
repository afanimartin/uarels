abstract class IAuthenticationRepository {
  Future<void> logInWithGoogleAccount();

  Future<void> logOut();
}

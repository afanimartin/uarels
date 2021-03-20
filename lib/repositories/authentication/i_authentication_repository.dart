import '../../models/models.dart';

abstract class IAuthenticationRepository {
  Future<UserModel> getCurrentUser();

  Future<void> logInWithGoogleAccount();

  Future<void> logOut();
}

import '../../models/models.dart';

abstract class IAuthenticationRepository {
  Future<UserModel> getCurrentUser();

  Future<UserModel> logInWithGoogleAccount();

  Future<void> logOut();
}

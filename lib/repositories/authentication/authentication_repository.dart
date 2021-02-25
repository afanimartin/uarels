import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/models.dart';
import 'i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn
                .standard(); // You will see errors without: GoogleSignIn.standard()

  Stream<UserModel> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) =>
          firebaseUser == null ? UserModel.empty : toUser(firebaseUser));

  @override
  Future<UserModel> logInWithGoogleAccount() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuthentication = await googleUser.authentication;

    final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);

    final user = await _firebaseAuth.signInWithCredential(googleCredential);

    return toUser(user.user);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }

    final user = toUser(currentUser);
    return user;
  }

  @override
  Future<void> logOut() async {
    await _googleSignIn.signOut();
  }

  UserModel toUser(User firebaseUser) => UserModel(
      userId: firebaseUser.uid,
      email: firebaseUser.email,
      username: firebaseUser.displayName,
      photo: firebaseUser.photoURL);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user/user.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        super();

  Stream<UserModel> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) =>
          firebaseUser == null ? UserModel.empty : _toUser(firebaseUser));

  @override
  Future<void> logInWithGoogleAccount() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuthentication = await googleUser.authentication;
    final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);

    await _firebaseAuth.signInWithCredential(googleAuthCredential);
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  UserModel _toUser(User user) => UserModel(
      userId: user.uid,
      email: user.email,
      username: user.displayName,
      photo: user.photoURL);
}

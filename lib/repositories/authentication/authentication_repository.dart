import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';
import '../../utils/paths.dart';
import 'i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthenticationRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> logInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();

    return toUser(authResult.user);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }

    return toUser(currentUser);
  }

  Future<UserModel> toUser(User firebaseUser) async {
    final userDoc = await _firebaseFirestore
        .collection(Paths.users)
        .doc(firebaseUser.uid)
        .get();

    if (userDoc.exists) {
      final user = UserModel.fromSnapshot(userDoc);

      return user;
    }

    return UserModel.empty;
  }
}

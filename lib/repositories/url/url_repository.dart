import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/url/url.dart';
import '../../utils/paths.dart';
import 'i_url_repository.dart';

class UrlRepository extends IUrlRepository {
  final FirebaseFirestore _firebaseFirestore;

  UrlRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> add(String collection, Url url) async {
    await _firebaseFirestore.collection(collection).add(await url.toDocument());
  }

  @override
  Future<void> update(String collection, Url url) async {
    await _firebaseFirestore
        .collection(collection)
        .doc(url.id)
        .update(await url.toDocument());
  }

  @override
  Future<void> delete(String collection, Url url) async {
    await _firebaseFirestore.collection(collection).doc(url.id).delete();
  }

  @override
  Stream<List<Url>> publicUrls() =>
      _firebaseFirestore.collection(Paths.public).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  @override
  Stream<List<Url>> privateUrls(String userId) => _firebaseFirestore
      .collection(Paths.private)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  @override
  Stream<List<Url>> favoriteUrls(String userId) => _firebaseFirestore
      .collection(Paths.favorites)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  Future<void> addToPublic(Url url) async {
    await add('public', url);
    await delete('private', url);
  }

  Future<void> addToFavorites(Url url) async {
    await add('favorites', url);
  }

  Future<void> addToPrivate(Url url) async {
    await add('private', url);
    await delete('public', url);
  }
}

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
  Stream<List<Url>> privateUrls() =>
      _firebaseFirestore.collection(Paths.private).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  @override
  Stream<List<Url>> favoriteUrls() => _firebaseFirestore
      .collection(Paths.favorites)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}

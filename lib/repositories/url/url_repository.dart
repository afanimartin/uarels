import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/url/url.dart';
import '../../utils/paths.dart';
import 'i_url_repository.dart';

class UrlRepository extends IUrlRepository {
  final FirebaseFirestore _firebaseFirestore;

  UrlRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> add(Url url) async {
    await _firebaseFirestore.collection(Paths.urls).add(await url.toDocument());
  }

  @override
  Future<void> update(Url url) async {
    await _firebaseFirestore
        .collection(Paths.urls)
        .doc(url.id)
        .update(await url.toDocument());
  }

  @override
  Future<void> delete(Url url) async {
    await _firebaseFirestore.collection(Paths.urls).doc(url.id).delete();
  }

  @override
  Stream<List<Url>> urls(String userId) =>
      _firebaseFirestore.collection(Paths.urls).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  Future<Url> makeUrlPrivateOrPublic(Url url) async {
    final updatedUrl = Url(
        userId: url.userId,
        id: url.id,
        inputUrl: url.inputUrl,
        isPrivate: !url.isPrivate,
        isFavorite: url.isFavorite,
        timestamp: url.timestamp);

    await update(updatedUrl);

    return updatedUrl;
  }

  Future<Url> addUrlToFavoritesOrRemove(Url url) async {
    final updatedUrl = Url(
        userId: url.userId,
        id: url.id,
        inputUrl: url.inputUrl,
        isPrivate: url.isPrivate,
        isFavorite: !url.isFavorite,
        timestamp: url.timestamp);

    await update(updatedUrl);

    return updatedUrl;
  }
}

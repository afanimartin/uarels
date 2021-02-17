import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/url/url.dart';
import '../../utils/paths.dart';
import 'i_url_repository.dart';

class UrlRepository extends IUrlRepository {
  final FirebaseFirestore _firebaseFirestore;

  UrlRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        super();

  @override
  Future<void> add(Url url) async {
    await _firebaseFirestore
        .collection(Paths.urls)
        .doc(url.urlId)
        .set(await url.toDocument());
  }

  @override
  Future<void> update(Url url) async {
    await _firebaseFirestore
        .collection(Paths.urls)
        .doc(url.urlId)
        .update(await url.toDocument());
  }

  @override
  Future<void> delete(Url url) async {
    await _firebaseFirestore.collection(Paths.urls).doc(url.urlId).delete();
  }

  @override
  Stream<List<Url>> urls(String userId) {
    _firebaseFirestore
        .collection(Paths.urls)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Url.fromSnapshot(doc)))
        .toList();
  }
}

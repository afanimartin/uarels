import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/url/url.dart';
import '../../utils/paths.dart';
import 'i_url_repository.dart';

class UrlRepository extends IUrlRepository {
  final _urlCollection = FirebaseFirestore.instance.collection(Paths.urls);

  @override
  Future<void> add(Url url) async =>
      _urlCollection.doc(url.urlId).set(await url.toDocument());

  @override
  Future<void> update(Url url) async =>
      _urlCollection.doc(url.urlId).update(await url.toDocument());

  @override
  Future<void> delete(Url url) async => _urlCollection.doc(url.urlId).delete();

  @override
  Stream<List<Url>> urls(String userId) => _urlCollection
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Url.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}

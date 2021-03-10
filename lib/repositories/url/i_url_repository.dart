import '../../models/models.dart';

abstract class IUrlRepository {
  Future<void> add(String collection, Url url);

  Future<void> update(String collection, Url url);

  Future<void> delete(String collection, Url url);

  Stream<List<Url>> publicUrls();

  Stream<List<Url>> privateUrls(String userId);

  Stream<List<Url>> favoriteUrls(String userId);
}

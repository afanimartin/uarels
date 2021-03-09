import '../../models/models.dart';

abstract class IUrlRepository {
  Future<void> add(String collection, Url url);

  Future<void> update(String collection, Url url);

  Future<void> delete(String collection, Url url);

  Stream<List<Url>> publicUrls();

  Stream<List<Url>> privateUrls();

  Stream<List<Url>> favoriteUrls();
}

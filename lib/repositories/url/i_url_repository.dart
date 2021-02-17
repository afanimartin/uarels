import '../../models/models.dart';

abstract class IUrlRepository {
  Future<void> add(Url url);

  Future<void> update(Url url);

  Future<void> delete(Url url);

  Stream<List<Url>> urls(String userId);
}

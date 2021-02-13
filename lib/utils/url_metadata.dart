import 'package:metadata_fetch/metadata_fetch.dart';

class UrlMetadata {
  static Future<Metadata> metadata(String url) async {
    final metadata = await extract(url);
    return metadata;
  }
}

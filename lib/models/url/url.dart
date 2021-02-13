import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uarels/utils/url_metadata.dart';

class Url extends Equatable {
  final String urlId, inputUrl, title, description, imageUrl;

  const Url(
      {@required this.urlId,
      @required this.inputUrl,
      this.title,
      this.description,
      this.imageUrl});

  Url copyWith(
          {String urlId,
          String inputUrl,
          String title,
          String description,
          String imageUrl}) =>
      Url(
          urlId: urlId ?? this.urlId,
          inputUrl: inputUrl ?? this.inputUrl,
          title: title ?? this.title,
          description: description ?? this.description,
          imageUrl: imageUrl ?? this.imageUrl);

  factory Url.fromSnapshot(DocumentSnapshot doc) => Url(
      urlId: doc.id,
      inputUrl: doc.data()['inputUrl'] as String,
      title: doc.data()['title'] as String,
      description: doc.data()['description'] as String,
      imageUrl: doc.data()['imageUrl'] as String);

  Future<Map<String, dynamic>> toDocument() async {
    final metadata = await UrlMetadata.metadata(inputUrl);

    return <String, dynamic>{
      'urlId': urlId,
      'inputUrl': inputUrl,
      'title': metadata.title,
      'description': metadata.description,
      'imageUrl': metadata.image
    };
  }

  @override
  List<Object> get props => [urlId, inputUrl, title, description, imageUrl];
}

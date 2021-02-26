import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../utils/url_metadata.dart';

class Url extends Equatable {
  final String userId, id, inputUrl, title, description, imageUrl;
  final bool isPrivate;
  final Timestamp timestamp;

  const Url(
      {@required this.userId,
      @required this.id,
      @required this.inputUrl,
      @required this.timestamp,
      this.title,
      this.description,
      this.imageUrl,
      this.isPrivate = false});

  Url copyWith(
          {String userId,
          String id,
          String inputUrl,
          String title,
          String description,
          String imageUrl,
          bool isPrivate,
          Timestamp timestamp}) =>
      Url(
          userId: userId ?? this.userId,
          id: id ?? this.id,
          inputUrl: inputUrl ?? this.inputUrl,
          title: title ?? this.title,
          description: description ?? this.description,
          imageUrl: imageUrl ?? this.imageUrl,
          timestamp: timestamp ?? this.timestamp,
          isPrivate: isPrivate ?? this.isPrivate);

  factory Url.fromSnapshot(DocumentSnapshot doc) => Url(
      userId: doc.data()['userId'] as String,
      id: doc.id,
      inputUrl: doc.data()['inputUrl'] as String,
      title: doc.data()['title'] as String,
      description: doc.data()['description'] as String,
      imageUrl: doc.data()['imageUrl'] as String,
      timestamp: doc.data()['timestamp'] as Timestamp,
      isPrivate: doc.data()['isPrivate'] as bool);

  Future<Map<String, dynamic>> toDocument() async {
    final metadata = await UrlMetadata.metadata(inputUrl);

    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'inputUrl': inputUrl,
      'title': metadata.title,
      'description': metadata.description,
      'imageUrl': metadata.image,
      'isPrivate': isPrivate,
      'timestamp': timestamp
    };
  }

  @override
  List<Object> get props => [
        id,
        userId,
        inputUrl,
        title,
        description,
        imageUrl,
        isPrivate,
        timestamp
      ];
}

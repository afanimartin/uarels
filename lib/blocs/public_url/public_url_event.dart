import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

abstract class PublicUrlEvent extends Equatable {
  const PublicUrlEvent();

  @override
  List<Object> get props => [];
}

class LoadPublicUrls extends PublicUrlEvent {}

class UpdateUrls extends PublicUrlEvent {
  final List<Url> urls;

  const UpdateUrls({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class AddUrl extends PublicUrlEvent {
  final String inputUrl;

  const AddUrl({@required this.inputUrl});

  @override
  List<Object> get props => [inputUrl];
}

class UpdateUrl extends PublicUrlEvent {
  final Url url;

  const UpdateUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

class DeleteUrl extends PublicUrlEvent {
  final Url url;

  const DeleteUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

class AddUrlToPrivate extends PublicUrlEvent {
  final Url url;

  const AddUrlToPrivate({@required this.url});

  @override
  List<Object> get props => [url];
}

class ShareUrl extends PublicUrlEvent {
  final String inputUrl;
  final String subject;

  const ShareUrl(
      {@required this.inputUrl,
      this.subject = 'Checkout this awesome article I found on Uarels'});

  @override
  List<Object> get props => [inputUrl];
}

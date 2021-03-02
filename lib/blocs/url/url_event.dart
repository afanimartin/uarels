import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

abstract class UrlEvent extends Equatable {
  const UrlEvent();

  @override
  List<Object> get props => [];
}

class LoadPublicUrls extends UrlEvent {}

class LoadPrivateUrls extends UrlEvent {}

class AddUrl extends UrlEvent {
  final String inputUrl;

  const AddUrl({@required this.inputUrl});

  @override
  List<Object> get props => [inputUrl];
}

class UpdateUrl extends UrlEvent {
  final Url url;

  const UpdateUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

class DeleteUrl extends UrlEvent {
  final Url url;

  const DeleteUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

class UpdateUrls extends UrlEvent {
  final List<Url> urls;

  const UpdateUrls({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class MakeUrlPrivateOrPublic extends UrlEvent {
  final Url url;

  const MakeUrlPrivateOrPublic({@required this.url});

  @override
  List<Object> get props => [url];
}

class AddUrlToFavoritesOrRemove extends UrlEvent {
  final Url url;

  const AddUrlToFavoritesOrRemove({@required this.url});

  @override
  List<Object> get props => [url];
}

class ShareUrl extends UrlEvent {
  final String inputUrl;
  final String subject;

  const ShareUrl(
      {@required this.inputUrl,
      this.subject = 'Checkout this awesome article I found on Uarels'});

  @override
  List<Object> get props => [inputUrl];
}

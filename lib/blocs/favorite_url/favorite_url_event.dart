import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';

abstract class FavoriteUrlEvent extends Equatable {
  const FavoriteUrlEvent();
}

class LoadUrls extends FavoriteUrlEvent {
  const LoadUrls();

  @override
  List<Object> get props => [];
}

class UpdateUrls extends FavoriteUrlEvent {
  final List<Url> urls;

  const UpdateUrls({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class AddUrlToFavorites extends FavoriteUrlEvent {
  final Url url;

  const AddUrlToFavorites({@required this.url});

  @override
  List<Object> get props => [url];
}

class RemoveFromFavorites extends FavoriteUrlEvent {
  final Url url;

  const RemoveFromFavorites({@required this.url});

  @override
  List<Object> get props => [url];
}

class AddToPrivate extends FavoriteUrlEvent {
  final Url url;

  const AddToPrivate({@required this.url});

  @override
  List<Object> get props => [url];
}

class ShareUrl extends FavoriteUrlEvent {
  final Url url;

  const ShareUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

class DeleteUrl extends FavoriteUrlEvent {
  final Url url;

  const DeleteUrl({@required this.url});

  @override
  List<Object> get props => [url];
}

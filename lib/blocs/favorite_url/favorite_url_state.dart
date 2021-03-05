import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';

class FavoriteUrlState extends Equatable {
  const FavoriteUrlState();

  @override
  List<Object> get props => [];
}

// LOADING URLS
class UrlsLoading extends FavoriteUrlState {}

class UrlsLoaded extends FavoriteUrlState {
  final List<Url> urls;

  const UrlsLoaded({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsLoadingFailed extends FavoriteUrlState {}

// UPDATING URLS
class UrlsUpdating extends FavoriteUrlState {}

class UrlsUpdated extends FavoriteUrlState {
  final List<Url> urls;

  const UrlsUpdated({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsUpdatingFailed extends FavoriteUrlState {}

// Remove Url
class RemovingUrl extends FavoriteUrlState {}

class UrlRemoved extends FavoriteUrlState {}

class RemovingUrlFailed extends FavoriteUrlState {}
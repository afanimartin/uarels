import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class UrlState extends Equatable {
  const UrlState();

  @override
  List<Object> get props => [];
}

class UrlsLoading extends UrlState {}

class UrlsLoaded extends UrlState {
  final List<Url> urls;

  const UrlsLoaded({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsLoadingFailed extends UrlState {}

class UrlsUpdating extends UrlState {}

class UrlsUpdated extends UrlState {
  final List<Url> urls;
  final String userId;

  const UrlsUpdated({@required this.urls, @required this.userId});

  @override
  List<Object> get props => [urls];

  List<Url> get publicUrls => urls.where((url) => !url.isPrivate).toList();

  List<Url> get privateUrls =>
      urls.where((url) => url.isPrivate && userId == url.userId).toList();

  List<Url> get favoriteUrls =>
      urls.where((url) => url.isFavorite && userId == url.userId).toList();
}

class PrivateUrlsUpdated extends UrlState {
  final List<Url> urls;

  const PrivateUrlsUpdated({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsUpdatingFailed extends UrlState {}

// ADD NEW URL
class UrlAdding extends UrlState {}

class UrlAdded extends UrlState {}

class UrlAddingFailed extends UrlState {}

// SHARE EXISTING URL
class SharingUrl extends UrlState {}

class UrlShared extends UrlState {}

class UrlSharingFailed extends UrlState {}

// DELETE EXISTING URL
class UrlDeleting extends UrlState {}

class UrlDeleted extends UrlState {}

class UrlDeletingFailed extends UrlState {}

// UPDATE EXISTING URL
class UrlUpdating extends UrlState {}

class UrlUpdated extends UrlState {}

class UrlUpdatingFailed extends UrlState {}

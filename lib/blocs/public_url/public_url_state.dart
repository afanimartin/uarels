import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class PublicUrlState extends Equatable {
  const PublicUrlState();

  @override
  List<Object> get props => [];
}

class PublicUrlsLoading extends PublicUrlState {}

class PublicUrlsLoaded extends PublicUrlState {
  final List<Url> urls;

  const PublicUrlsLoaded({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class PublicUrlsLoadingFailed extends PublicUrlState {}

class PublicUrlsUpdating extends PublicUrlState {}

class PublicUrlsUpdated extends PublicUrlState {
  final List<Url> urls;
  final String userId;

  const PublicUrlsUpdated({@required this.urls, @required this.userId});

  @override
  List<Object> get props => [urls];
}

class PublicUrlsUpdatingFailed extends PublicUrlState {}

// ADD NEW URL
class UrlAdding extends PublicUrlState {}

class UrlAdded extends PublicUrlState {}

class UrlAddingFailed extends PublicUrlState {}

// SHARE EXISTING URL
class SharingUrl extends PublicUrlState {}

class UrlShared extends PublicUrlState {}

class UrlSharingFailed extends PublicUrlState {}

// DELETE EXISTING URL
class UrlDeleting extends PublicUrlState {}

class UrlDeleted extends PublicUrlState {}

class UrlDeletingFailed extends PublicUrlState {}

// ADD URL TO FAVORITES/PRIVATE
class AddingUrl extends PublicUrlState {}

class AddedUrl extends PublicUrlState {}

class AddingUrlFailed extends PublicUrlState {}

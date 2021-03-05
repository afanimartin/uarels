import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';

class PrivateUrlState extends Equatable {
  const PrivateUrlState();

  @override
  List<Object> get props => [];
}

// LOAD URLs
class PrivateUrlsLoading extends PrivateUrlState {}

class UrlsLoaded extends PrivateUrlState {
  final List<Url> urls;

  const UrlsLoaded({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsLoadingFailed extends PrivateUrlState {}

// UPDATE URLs
class PrivateUrlsUpdating extends PrivateUrlState {}

class PrivateUrlsUpdated extends PrivateUrlState {
  final List<Url> urls;

  const PrivateUrlsUpdated({@required this.urls});

  @override
  List<Object> get props => [urls];

  List<Url> get privateUrls => urls.where((url) => url.isPrivate).toList();
}

class PrivateUrlsUpdatingFailed extends PrivateUrlState {}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

abstract class UrlState extends Equatable {
  const UrlState();

  @override
  List<Object> get props => [];
}

class InitialState extends UrlState {}

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

  const UrlsUpdated({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class UrlsUpdatingFailed extends UrlState {}

// ADD NEW URL
class UrlAdding extends UrlState {}

class UrlAdded extends UrlState {}

class UrlAddingFailed extends UrlState {}

// DELETE EXISTING URL
class UrlDeleting extends UrlState {}

class UrlDeleted extends UrlState {}

class UrlDeletingFailed extends UrlState {}

// UPDATE EXISTING URL
class UrlUpdating extends UrlState {}

class UrlUpdated extends UrlState {}

class UrlUpdatingFailed extends UrlState {}

class LaunchingUrl extends UrlState {}

class UrlLaunched extends UrlState {
  final String url;

  const UrlLaunched({@required this.url});

  @override
  List<Object> get props => [url];
}

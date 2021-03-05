import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class PrivateUrlEvent extends Equatable {
  const PrivateUrlEvent();

  @override
  List<Object> get props => [];
}

class LoadPrivateUrls extends PrivateUrlEvent {}

class UpdateUrls extends PrivateUrlEvent {
  final List<Url> urls;

  const UpdateUrls({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class AddUrlToPublic extends PrivateUrlEvent {
  final Url url;

  const AddUrlToPublic({@required this.url});

  @override
  List<Object> get props => [url];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

abstract class UrlEvent extends Equatable {
  const UrlEvent();

  @override
  List<Object> get props => [];
}

class LoadUrls extends UrlEvent {}

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

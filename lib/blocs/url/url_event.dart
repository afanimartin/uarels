import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../models/user/user.dart';

class UrlEvent extends Equatable {
  final UserModel user;
  final List<Url> urls;

  const UrlEvent({@required this.user, @required this.urls});

  @override
  List<Object> get props => [user, urls];
}

// class FetchAllUrls extends UrlEvent {
//   final UserModel user;

//   const FetchAllUrls({@required this.user});

//   @override
//   List<Object> get props => [user];
// }

// class UpdateUrls extends UrlEvent {
//   final List<Url> urls;

//   const UpdateUrls({@required this.urls});

//   @override
//   List<Object> get props => [urls];
// }

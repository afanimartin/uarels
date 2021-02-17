import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../models/user/user.dart';

class UrlState extends Equatable {
  final UserModel user;
  final List<Url> urls;

  const UrlState({this.user = UserModel.empty, this.urls});

  @override
  List<Object> get props => [user, urls];
}

class UrlsLoaded extends UrlState {}

class UrlsLoading extends UrlState {}

class UrlsFailedToLoad extends UrlState {}

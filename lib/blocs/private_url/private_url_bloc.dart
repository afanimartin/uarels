import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../repositories/repositories.dart';
import '../../repositories/url/url_repository.dart';
import '../authentication/authentication_bloc.dart';
import 'private_url_event.dart';
import 'private_url_state.dart';

class PrivateUrlBloc extends Bloc<PrivateUrlEvent, PrivateUrlState> {
  final UrlRepository _urlRepository;

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  StreamSubscription _privateUrlsStreamSubscription;

  PrivateUrlBloc({@required UrlRepository urlRepository})
      : _urlRepository = urlRepository,
        super(const PrivateUrlState());

  @override
  Stream<PrivateUrlState> mapEventToState(PrivateUrlEvent event) async* {
    if (event is LoadPrivateUrls) {
      yield* _mapLoadUrlsToState();
    } else if (event is UpdateUrls) {
      yield* _mapUpdateUrlsToState(event);
    } else if (event is AddUrlToPublic) {
      yield* _mapAddUrlToPublicState(event);
    }
  }

  Stream<PrivateUrlState> _mapLoadUrlsToState() async* {
    yield PrivateUrlsUpdating();

    try {
      await _privateUrlsStreamSubscription?.cancel();

      final currentUserId = _currentUserId.getCurrentUserId();

      _privateUrlsStreamSubscription = _urlRepository
          .privateUrls(currentUserId)
          .listen((urls) => add(UpdateUrls(urls: urls)));
    } on Exception catch (_) {
      yield PrivateUrlsUpdatingFailed();
    }
  }

  Stream<PrivateUrlState> _mapUpdateUrlsToState(UpdateUrls event) async* {
    yield PrivateUrlsUpdated(urls: event.urls);
  }

  Stream<PrivateUrlState> _mapAddUrlToPublicState(AddUrlToPublic event) async* {
    yield AddingUrlToPublic();

    try {
      await _urlRepository.addToPublic(event.url);

      yield UrlAddedToPublic();
    } on Exception catch (_) {
      yield UrlAddingToPublicFailed();
    }
  }
}

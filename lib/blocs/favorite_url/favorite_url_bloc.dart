import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../repositories/url/url_repository.dart';
import '../blocs.dart';
import 'favorite_url_event.dart';
import 'favorite_url_state.dart';

class FavoriteUrlBloc extends Bloc<FavoriteUrlEvent, FavoriteUrlState> {
  final UrlRepository _urlRepository;

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  StreamSubscription _favoriteUrlStreamSubscription;

  FavoriteUrlBloc({
    @required UrlRepository urlRepository,
  })  : _urlRepository = urlRepository,
        super(const FavoriteUrlState());

  @override
  Stream<FavoriteUrlState> mapEventToState(FavoriteUrlEvent event) async* {
    if (event is LoadUrls) {
      yield* _mapLoadUrlsToState();
    } else if (event is UpdateUrls) {
      yield* _mapUpdateUrlsToState(event);
    } else if (event is RemoveFromFavorites) {
      yield* _mapRemoveFromFavoritesToState(event);
    } else if (event is AddUrlToFavorites) {
      yield* _mapAddUrlToFavorites(event);
    }
  }

  Stream<FavoriteUrlState> _mapLoadUrlsToState() async* {
    yield UrlsLoading();

    try {
      await _favoriteUrlStreamSubscription?.cancel();

      final currentUserId = _currentUserId.getCurrentUserId();

      _favoriteUrlStreamSubscription = _urlRepository
          .favoriteUrls(currentUserId)
          .listen((urls) => add(UpdateUrls(urls: urls)));
    } on Exception catch (_) {
      yield UrlsLoadingFailed();
    }
  }

  Stream<FavoriteUrlState> _mapUpdateUrlsToState(UpdateUrls event) async* {
    yield UrlsUpdated(urls: event.urls);
  }

  Stream<FavoriteUrlState> _mapAddUrlToFavorites(
      AddUrlToFavorites event) async* {
    try {
      final currentUserId = _currentUserId.getCurrentUserId();

      final url = Url(
          userId: currentUserId,
          id: event.url.id,
          inputUrl: event.url.inputUrl,
          isFavorite: true,
          timestamp: Timestamp.now());

      await _urlRepository.addUrlToFavorites(url);
    } on Exception catch (_) {}
  }

  Stream<FavoriteUrlState> _mapRemoveFromFavoritesToState(
      RemoveFromFavorites event) async* {
    yield RemovingUrl();

    try {
      await _urlRepository.removeFromFavorites(event.url);

      yield UrlRemoved();
    } on Exception catch (_) {
      yield RemovingUrlFailed();
    }
  }

  @override
  Future<void> close() {
    _favoriteUrlStreamSubscription.cancel();

    return super.close();
  }
}
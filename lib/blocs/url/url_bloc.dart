import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

import '../../models/url/url.dart';
import '../../repositories/url/url_repository.dart';
import '../authentication/authentication_state.dart';
import '../blocs.dart';
import 'url_event.dart';
import 'url_state.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  final UrlRepository _urlRepository;
  final AuthenticationBloc _authenticationBloc;

  StreamSubscription _urlStreamSubscription;

  UrlBloc(
      {@required UrlRepository urlRepository,
      @required AuthenticationBloc authenticationBloc})
      : _urlRepository = urlRepository,
        _authenticationBloc = authenticationBloc,
        super(const UrlState());

  @override
  Stream<UrlState> mapEventToState(UrlEvent event) async* {
    if (event is LoadPublicUrls) {
      yield* _mapLoadPublicUrlsToState();
    } else if (event is UpdateUrls) {
      yield* _mapUrlsUpdatedToState(event);
    } else if (event is AddUrl) {
      yield* _mapAddUrlToState(event);
    } else if (event is UpdateUrl) {
      yield* _mapUpdateUrlToState(event);
    } else if (event is DeleteUrl) {
      yield* _mapDeleteUrlToState(event);
    } else if (event is MakeUrlPrivateOrPublic) {
      yield* _mapMakeUrlPrivate(event);
    } else if (event is AddUrlToFavoritesOrRemove) {
      yield* _mapAddUrlToFavoritesOrRemove(event);
    } else if (event is ShareUrl) {
      yield* _mapShareUrlToState(event);
    }
  }

  String _getCurrentUserId() {
    final authState = _authenticationBloc.state;

    String currentUserId;

    if (authState is AuthenticationState) {
      currentUserId = authState.user.userId;
    }
    return currentUserId;
  }

  Stream<UrlState> _mapLoadPublicUrlsToState() async* {
    yield UrlsLoading();

    try {
      await _urlStreamSubscription?.cancel();

      final userId = _getCurrentUserId();

      _urlStreamSubscription = _urlRepository
          .urls(userId)
          .listen((urls) => add(UpdateUrls(urls: urls)));
    } on Exception catch (_) {
      yield UrlsLoadingFailed();
    }
  }

  Stream<UrlState> _mapAddUrlToState(AddUrl event) async* {
    yield UrlAdding();

    try {
      final userId = _getCurrentUserId();

      final url = Url(
          userId: userId,
          id: Uuid().v4(),
          inputUrl: event.inputUrl,
          timestamp: Timestamp.now());

      await _urlRepository.add(url);

      yield UrlAdded();
    } on Exception catch (_) {
      yield UrlAddingFailed();
    }
  }

  Stream<UrlState> _mapUpdateUrlToState(UpdateUrl event) async* {
    yield UrlUpdating();

    try {
      await _urlRepository.update(event.url);

      yield UrlUpdated();
    } on Exception catch (_) {
      yield UrlUpdatingFailed();
    }
  }

  Stream<UrlState> _mapMakeUrlPrivate(MakeUrlPrivateOrPublic event) async* {
    yield UrlUpdating();

    try {
      await _urlRepository.makeUrlPrivateOrPublic(event.url);

      yield UrlUpdated();
    } on Exception catch (_) {
      yield UrlUpdatingFailed();
    }
  }

  Stream<UrlState> _mapAddUrlToFavoritesOrRemove(
      AddUrlToFavoritesOrRemove event) async* {
    yield UrlUpdating();

    try {
      await _urlRepository.addUrlToFavoritesOrRemove(event.url);

      yield UrlUpdated();
    } on Exception catch (_) {
      yield UrlUpdatingFailed();
    }
  }

  Stream<UrlState> _mapShareUrlToState(ShareUrl event) async* {
    try {
      await Share.share(event.inputUrl, subject: event.subject);
    } on Exception catch (_) {
      yield UrlSharingFailed();
    }
  }

  Stream<UrlState> _mapDeleteUrlToState(DeleteUrl event) async* {
    yield UrlDeleting();

    try {
      await _urlRepository.delete(event.url);

      yield UrlDeleted();
    } on Exception catch (_) {
      yield UrlDeletingFailed();
    }
  }

  Stream<UrlState> _mapUrlsUpdatedToState(UpdateUrls event) async* {
    final currentUserId = _getCurrentUserId();

    yield UrlsUpdated(urls: event.urls, userId: currentUserId);
  }

  @override
  Future<void> close() {
    _urlStreamSubscription.cancel();

    return super.close();
  }
}

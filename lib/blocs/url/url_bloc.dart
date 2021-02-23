import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        super(InitialState());

  @override
  Stream<UrlState> mapEventToState(UrlEvent event) async* {
    if (event is LoadUrls) {
      yield* _mapLoadUrlsToState();
    } else if (event is UpdateUrls) {
      yield* _mapUrlsUpdatedToState(event);
    } else if (event is AddUrl) {
      yield* _mapAddUrlToState(event);
    } else if (event is UpdateUrl) {
      yield* _mapUpdateUrlToState(event);
    } else if (event is DeleteUrl) {
      yield* _mapDeleteUrlToState(event);
    }
  }

  String _getCurrentUserId() {
    final authState = _authenticationBloc.state;

    String currentUserId;

    if (authState is Authenticated) {
      currentUserId = authState.user.userId;
    }
    return currentUserId;
  }

  Stream<UrlState> _mapLoadUrlsToState() async* {
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
          userId: userId, inputUrl: event.inputUrl, timestamp: Timestamp.now());

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
    yield UrlsUpdated(urls: event.urls);
  }

  @override
  Future<void> close() {
    _urlStreamSubscription.cancel();

    return super.close();
  }
}

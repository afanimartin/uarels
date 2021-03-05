import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../models/url/url.dart';
import '../../repositories/repositories.dart';
import '../../repositories/url/url_repository.dart';
import '../blocs.dart';
import 'public_url_event.dart';
import 'public_url_state.dart';

class PublicUrlBloc extends Bloc<PublicUrlEvent, PublicUrlState> {
  final UrlRepository _urlRepository;

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  StreamSubscription _urlStreamSubscription;

  PublicUrlBloc({
    @required UrlRepository urlRepository,
  })  : _urlRepository = urlRepository,
        super(const PublicUrlState());

  @override
  Stream<PublicUrlState> mapEventToState(PublicUrlEvent event) async* {
    if (event is LoadPublicUrls) {
      yield* _mapLoadPublicUrlsToState();
    } else if (event is UpdateUrls) {
      yield* _mapUrlsUpdatedToState(event);
    } else if (event is AddUrl) {
      yield* _mapAddUrlToState(event);
    } else if (event is AddUrlToPrivate) {
      yield* _mapAddUrlToPrivate(event);
    } else if (event is ShareUrl) {
      yield* _mapShareUrlToState(event);
    }
  }

  Stream<PublicUrlState> _mapLoadPublicUrlsToState() async* {
    yield PublicUrlsLoading();

    try {
      await _urlStreamSubscription?.cancel();

      final userId = _currentUserId.getCurrentUserId();

      _urlStreamSubscription = _urlRepository
          .urls(userId)
          .listen((urls) => add(UpdateUrls(urls: urls)));
    } on Exception catch (_) {
      yield PublicUrlsLoadingFailed();
    }
  }

  Stream<PublicUrlState> _mapAddUrlToState(AddUrl event) async* {
    yield UrlAdding();

    try {
      final userId = _currentUserId.getCurrentUserId();

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

  Stream<PublicUrlState> _mapAddUrlToPrivate(AddUrlToPrivate event) async* {
    yield AddingUrl();
    try {
      await _urlRepository.addUrlToPrivate(event.url);

      yield AddedUrl();
    } on Exception catch (_) {
      yield AddingUrlFailed();
    }
  }

  Stream<PublicUrlState> _mapShareUrlToState(ShareUrl event) async* {
    try {
      await Share.share(event.inputUrl, subject: event.subject);
    } on Exception catch (_) {
      yield UrlSharingFailed();
    }
  }

  Stream<PublicUrlState> _mapUrlsUpdatedToState(UpdateUrls event) async* {
    final currentUserId = _currentUserId.getCurrentUserId();

    yield PublicUrlsUpdated(urls: event.urls, userId: currentUserId);
  }

  @override
  Future<void> close() {
    _urlStreamSubscription.cancel();

    return super.close();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/url/url_repository.dart';
import 'url_event.dart';
import 'url_state.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  final UrlRepository _urlRepository;
  StreamSubscription _urlsStreamSubscription;

  UrlBloc({@required UrlRepository urlRepository})
      : _urlRepository = urlRepository ?? UrlRepository(),
        super(const UrlState());

  @override
  Stream<UrlState> mapEventToState(UrlEvent event) async* {
    if (event is UrlEvent) {
      yield* _mapFetchAllUrlsToState(event);
    }
    // else if (event is UpdateUrls) {
    //   yield* _mapUpdateUrlsToState(event);
    // }
  }

  Stream<UrlState> _mapFetchAllUrlsToState(UrlEvent event) async* {
    yield UrlsLoading();

    try {
      await _urlsStreamSubscription?.cancel();

      _urlsStreamSubscription = _urlRepository
          .urls(event.user.userId)
          .listen((urls) => add(UrlEvent(urls: urls, user: event.user)));
    } on Exception catch (error) {
      print(error);
      
      yield UrlsFailedToLoad();
    }
  }

  // Stream<UrlState> _mapUpdateUrlsToState(UpdateUrls event) async* {
  //   yield UrlsLoaded(urls: event.urls);
  // }

  @override
  Future<void> close() {
    _urlsStreamSubscription.cancel();

    return super.close();
  }
}

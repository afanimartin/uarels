import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'blocs/favorite_url/favorite_url_event.dart';
import 'blocs/log_in/log_in_bloc.dart';
import 'blocs/private_url/private_url_event.dart';
import 'blocs/public_url/public_url_event.dart';
import 'blocs/simple_bloc_observer.dart';
import 'blocs/tab/tab_bloc.dart';
import 'repositories/repositories.dart';
import 'repositories/url/url_repository.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  EquatableConfig.stringify = kDebugMode;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
              authenticationRepository: AuthenticationRepository()),
        ),
        BlocProvider<PublicUrlBloc>(
            create: (_) => PublicUrlBloc(
                  urlRepository: UrlRepository(),
                )..add(LoadPublicUrls())),
        BlocProvider<LogInCubit>(
          create: (_) =>
              LogInCubit(authenticationRepository: AuthenticationRepository()),
        ),
        BlocProvider<TabBloc>(
          create: (_) => TabBloc(),
        ),
        BlocProvider<FavoriteUrlBloc>(
          create: (_) => FavoriteUrlBloc(urlRepository: UrlRepository())
            ..add(const LoadUrls()),
        ),
        BlocProvider<PrivateUrlBloc>(
          create: (_) => PrivateUrlBloc(urlRepository: UrlRepository())
            ..add(LoadPrivateUrls()),
        )
      ],
      child: const App(),
    ),
  );
}

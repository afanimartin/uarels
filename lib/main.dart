import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'blocs/simple_bloc_observer.dart';
import 'blocs/url/url_bloc.dart';
import 'repositories/repositories.dart';
import 'repositories/url/url_repository.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  EquatableConfig.stringify = kDebugMode;

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>(
        create: (_) => AuthenticationRepository(),
      ),
      RepositoryProvider<UrlRepository>(
        create: (_) => UrlRepository(),
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
              authenticationRepository: AuthenticationRepository()),
        ),
        BlocProvider<UrlBloc>(
          create: (_) => UrlBloc(urlRepository: UrlRepository()),
        )
      ],
      child: const App(),
    ),
  ));
}

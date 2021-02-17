import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/authentication/authentication_event.dart';
import '../blocs/url/url_bloc.dart';
import '../blocs/url/url_event.dart';
import '../blocs/url/url_state.dart';
import '../widgets/avatar.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Avatar(
            photoUrl: user.photo,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Uarels',
          style:
              TextStyle(fontSize: 24, letterSpacing: 1.2, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogOutRequested());
              })
        ],
      ),
      body: BlocBuilder<UrlBloc, UrlState>(builder: (context, state) {
        if (state == null) {
          return const ProgressLoader();
        }
        if (state is UrlsLoaded) {
          context
              .read<UrlBloc>()
              .add(UrlEvent(user: state.user, urls: state.urls));
        }

        return const Center(
            child: Text(
          'No Urls to load at this time',
          style: TextStyle(fontSize: 20),
        ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

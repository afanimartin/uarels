import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/authentication/authentication_event.dart';
import '../widgets/avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
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
          style: TextStyle(fontSize: 24, letterSpacing: 1.2),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                size: 30,
              ),
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogOutRequested()))
        ],
      ),
    );
  }
}

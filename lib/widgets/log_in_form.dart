import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/log_in/log_in_bloc.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const _GoogleLogInButton(
      // appBar: AppBar(),
      // body: Align(
      //   alignment: const Alignment(0, -1 / 3),
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(top: 20, bottom: 10),
      //         child: Image.asset(
      //           'assets/uarels-logo.png',
      //           height: 20,
      //         ),
      //       ),
      //       const _GoogleLogInButton()
      //     ],
      //   ),
      // ),
      );
}

class _GoogleLogInButton extends StatelessWidget {
  const _GoogleLogInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        key: const Key('google_log_in_button'),
        onPressed: () => context.read<LogInCubit>().logInWithGoogle(),
        child: const Text('Sign in with Google',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      );
}

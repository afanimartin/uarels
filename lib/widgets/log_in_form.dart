import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/log_in/log_in_bloc.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Log In',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/uarels-logo.png',
                  height: 80,
                ),
              ),
              const _GoogleLogInButton()
            ],
          ),
        ),
      );
}

class _GoogleLogInButton extends StatelessWidget {
  const _GoogleLogInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        key: const Key('google_log_in_button'),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor)),
        onPressed: () => context.read<LogInCubit>().logInWithGoogle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(FontAwesomeIcons.google),
              const SizedBox(
                width: 4,
              ),
              const Text('Sign in with Google',
                  style: TextStyle(color: Colors.white, fontSize: 22)),
            ],
          ),
        ),
      );
}

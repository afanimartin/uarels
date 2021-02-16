import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/log_in/log_in_cubit.dart';
import '../repositories/repositories.dart';
import '../widgets/log_in_form.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const LogInScreen());

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) =>
          LogInCubit(authenticationRepository: AuthenticationRepository()),
      child: const LogInForm());
}

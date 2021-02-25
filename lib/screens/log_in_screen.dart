import 'package:flutter/material.dart';

import '../widgets/log_in_form.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const LogInScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const LogInForm(),
        ),
      );
}

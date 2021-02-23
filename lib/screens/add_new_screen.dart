import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add new url'),
          backgroundColor: Colors.white,
        ),
        body: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: _UrlForm(),
            )
          ],
        ),
      );
}

class _UrlForm extends StatelessWidget {
  const _UrlForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 80),
        child: TextField(
          key: Key('new_url_textfield'),
          decoration: InputDecoration.collapsed(hintText: 'Enter url :)'),
        ),
      );
}

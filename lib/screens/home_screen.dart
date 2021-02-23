import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../blocs/url/url_event.dart';
import '../blocs/url/url_state.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final _urlTextEditingController = TextEditingController();

  HomeScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => HomeScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text(
            'Uarels',
            style: TextStyle(
                fontSize: 24, letterSpacing: 1.2, color: Colors.black),
          ),
        ),
        body: BlocBuilder<UrlBloc, UrlState>(
            cubit: context.watch<UrlBloc>(),
            builder: (context, state) {
              if (state is UrlsLoading) {
                return const ProgressLoader();
              }

              if (state is UrlAdding) {
                return const ProgressLoader();
              }

              if (state is UrlsUpdated) {
                return ListView.builder(
                    itemCount: state?.urls?.length,
                    itemBuilder: (context, index) {
                      final url = state.urls[index];

                      return Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20, top: 20),
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12, offset: Offset(0, 2))
                            ]),
                        child: Column(
                          children: [
                            CachedNetworkImage(imageUrl: url.imageUrl),
                            ListTile(
                              title: Text(url.title),
                            ),
                          ],
                        ),
                      );
                    });
              }

              return const Center(
                child: Text('No Urls to load'),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _buildUrlForm(context),
          backgroundColor: Colors.cyan[700],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );

  Future<Widget> _buildUrlForm(BuildContext context) => showDialog(
      context: context,
      child: AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              const Text('Add new url'),
              TextField(
                controller: _urlTextEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter url link'),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                _urlTextEditingController.clear();

                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          FlatButton(
              onPressed: () {
                if (_urlTextEditingController.text.isNotEmpty) {
                  context
                      .read<UrlBloc>()
                      .add(AddUrl(inputUrl: _urlTextEditingController.text));

                  _urlTextEditingController.clear();

                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Save',
              ))
        ],
      ));
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/authentication/authentication_event.dart';
import '../blocs/blocs.dart';
import '../blocs/url/url_event.dart';
import '../blocs/url/url_state.dart';
import '../widgets/widgets.dart';
import 'article_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text(
            'Uarels',
            style: TextStyle(
                fontSize: 28, letterSpacing: 1.2, color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 28,
                ),
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(LogUserOut()))
          ],
        ),
        body: BlocBuilder<UrlBloc, UrlState>(builder: (context, state) {
          if (state is UrlsLoading ||
              state is UrlAdding ||
              state is UrlDeleting) {
            return const ProgressLoader();
          }

          if (state is UrlsUpdated) {
            return state.urls.isEmpty
                ? const Center(child: Text('No Urls to load'))
                : ListView.builder(
                    itemCount: state?.urls?.length,
                    itemBuilder: (context, index) {
                      final url = state.urls[index];

                      return GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ArticleDetails(
                                      url: url.inputUrl,
                                      appBarTitle: url.title,
                                    ))),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 20, top: 20),
                          height: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, offset: Offset(0, 2))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                child: CachedNetworkImage(
                                  imageUrl: url.imageUrl,
                                  fit: BoxFit.cover,
                                  maxHeightDiskCache: 200,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 5),
                                child: Text(
                                  url.title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat.yMd()
                                          .add_jm()
                                          .format(url.timestamp.toDate()),
                                    ),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 20,
                                        ),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline_sharp),
                                        onPressed: () => context
                                            .read<UrlBloc>()
                                            .add(DeleteUrl(url: url)))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
          }

          return const Text('');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _buildUrlForm(context),
          backgroundColor: Theme.of(context).primaryColor,
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
                style: TextStyle(color: Colors.red, fontSize: 18),
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
              child: Text(
                'Save',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ))
        ],
      ));
}

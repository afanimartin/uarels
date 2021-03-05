import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/private_url/private_url_event.dart';
import '../blocs/private_url/private_url_state.dart';
import '../models/models.dart';
import '../models/url/url.dart';
import '../screens/article_details.dart';
import 'progress_loader.dart';

class PrivateUrls extends StatelessWidget {
  const PrivateUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<PrivateUrlBloc, PrivateUrlState>(
        builder: (context, state) {
      if (state is PrivateUrlsLoading || state is AddingUrlToPublic) {
        return const ProgressLoader();
      }

      if (state is PrivateUrlsUpdated) {
        return state.privateUrls.isEmpty
            ? const Center(child: Text('No private urls to load'))
            : ListView.builder(
                itemCount: state?.privateUrls?.length,
                itemBuilder: (context, index) {
                  final url = state.privateUrls[index];

                  return _RenderPrivateUrl(
                    url: url,
                    user: user,
                    key: const Key('private_urls'),
                  );
                });
      }

      return const Text('');
    });
  }
}

class _RenderPrivateUrl extends StatelessWidget {
  final Url url;
  final UserModel user;

  _RenderPrivateUrl({@required this.url, @required this.user, Key key})
      : super(key: key);

  PrivateUrlBloc _privateBloc;

  @override
  Widget build(BuildContext context) {
    _privateBloc = BlocProvider.of<PrivateUrlBloc>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ArticleDetails(
                url: url.inputUrl,
                appBarTitle: url.title,
              ))),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black12, offset: Offset(0, 2))
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar(photoUrl: url.photoUrl),
                  Text(
                    DateFormat.yMd().add_jm().format(url.timestamp.toDate()),
                  ),

                  PopupMenuButton<String>(
                      onSelected: handleClick,
                      itemBuilder: (context) => {'Make public'}
                          .map((choice) => PopupMenuItem<String>(
                              value: choice, child: Text(choice)))
                          .toList())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Make public':
        _privateBloc.add(AddUrlToPublic(url: url));
        break;

      default:
        break;
    }
  }
}

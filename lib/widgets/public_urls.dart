import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/favorite_url/favorite_url_event.dart';
import '../blocs/public_url/public_url_bloc.dart';
import '../blocs/public_url/public_url_state.dart';
import '../models/models.dart';
import '../models/url/url.dart';
import '../screens/article_details.dart';
import 'progress_loader.dart';

class PublicUrls extends StatelessWidget {
  const PublicUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<PublicUrlBloc, PublicUrlState>(
        builder: (context, state) {
      if (state is PublicUrlsLoading ||
          state is UrlAdding ||
          state is UrlDeleting ||
          state is SharingUrl) {
        return const ProgressLoader();
      }

      if (state is PublicUrlsUpdated) {
        return state.urls.isEmpty
            ? const Center(child: Text('No Urls to load'))
            : ListView.builder(
                itemCount: state?.urls?.length,
                itemBuilder: (context, index) {
                  final url = state.urls[index];

                  return _RenderPublicUrl(
                    url: url,
                    user: user,
                    key: const Key('public_urls'),
                  );
                });
      }

      return const Text('');
    });
  }
}

class _RenderPublicUrl extends StatelessWidget {
  final Url url;
  final UserModel user;

  _RenderPublicUrl({@required this.url, @required this.user, Key key})
      : super(key: key);

  PublicUrlBloc _publicBloc;
  FavoriteUrlBloc _favoriteUrlBloc;

  @override
  Widget build(BuildContext context) {
    _publicBloc = BlocProvider.of<PublicUrlBloc>(context);
    _favoriteUrlBloc = BlocProvider.of<FavoriteUrlBloc>(context);

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
                      itemBuilder: (context) => {'Add to favorites'}
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
      case 'Add to favorites':
        _favoriteUrlBloc.add(AddUrlToFavorites(url: url));
        break;

      default:
        break;
    }
  }
}

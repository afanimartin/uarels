import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/blocs.dart';
import '../blocs/favorite_url/favorite_url_event.dart';
import '../blocs/favorite_url/favorite_url_state.dart';
import '../models/models.dart';
import '../screens/article_details.dart';
import 'progress_loader.dart';
class FavoriteUrls extends StatelessWidget {
  const FavoriteUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<FavoriteUrlBloc, FavoriteUrlState>(
        builder: (context, state) {
      if (state is UrlsLoading || state is RemovingUrl) {
        return const ProgressLoader();
      }

      if (state is UrlsUpdated) {
        return state.urls.isEmpty
            ? const Center(child: Text('No favorite urls to load'))
            : ListView.builder(
                itemCount: state?.urls?.length,
                itemBuilder: (context, index) {
                  final url = state.urls[index];

                  return _RenderFavoriteUrl(
                    url: url,
                    user: user,
                    key: const Key('favorite_urls'),
                  );
                });
      }

      return const Center(child: Text('No data'));
    });
  }
}

class _RenderFavoriteUrl extends StatelessWidget {
  final Url url;
  final UserModel user;

  _RenderFavoriteUrl({@required this.url, @required this.user, Key key})
      : super(key: key);

  FavoriteUrlBloc _favoriteUrlBloc;

  @override
  Widget build(BuildContext context) {
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
                      itemBuilder: (context) => {
                            'Remove from favorites',
                            if (url.userId == user.userId) 'Add to private'
                          }
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
      case 'Remove from favorites':
        _favoriteUrlBloc.add(RemoveFromFavorites(url: url));
        break;
      case 'Add to private':
        _favoriteUrlBloc.add(AddToPrivate(url: url));
        break;

      default:
        break;
    }
  }
}

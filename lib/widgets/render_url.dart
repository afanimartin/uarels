import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/blocs.dart';
import '../blocs/favorite_url/favorite_url_event.dart';
import '../models/models.dart';
import '../screens/article_details.dart';

class RenderUrl extends StatelessWidget {
  final Url url;
  final UserModel user;

  RenderUrl({@required this.url, @required this.user, Key key})
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
                  Text(timeago.format(url.timestamp.toDate())),

                  PopupMenuButton<String>(
                      onSelected: handleClick,
                      itemBuilder: (context) => {
                            if (!url.isPrivate && !url.isFavorite)
                              'Add to favorites',
                            if (url.userId == user.userId && !url.isPrivate)
                              'Add to private',
                            if (url.isPrivate) 'Remove from private',
                            if (url.isFavorite) 'Remove from favorites',
                            if (url.isPrivate) 'Delete',
                            if (!url.isFavorite && !url.isPrivate) 'Share'
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
      case 'Add to favorites':
        _favoriteUrlBloc.add(AddUrlToFavorites(url: url));
        break;
      case 'Add to private':
        _favoriteUrlBloc.add(AddUrlToPrivate(url: url));
        break;

      default:
        break;
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/blocs.dart';
import '../blocs/url/url_event.dart';
import '../models/models.dart';
import '../screens/article_details.dart';

class RenderArticle extends StatelessWidget {
  final Url url;
  final UserModel user;

  RenderArticle({@required this.url, @required this.user, Key key})
      : super(key: key);

  UrlBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<UrlBloc>(context);

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
                  // Avatar(photoUrl: url.),
                  Text(
                    DateFormat.yMd().add_jm().format(url.timestamp.toDate()),
                  ),
                  if (user.userId == url.userId)
                    PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (context) => {'Make private', 'Delete'}
                            .map((choice) => PopupMenuItem<String>(
                                value: choice, child: Text(choice)))
                            .toList())
                  else
                    const Text('')
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
      case 'Make private':
        _bloc.add(MakeUrlPrivate(url: url));
        break;
      case 'Delete':
        _bloc.add(DeleteUrl(url: url));
        break;

      default:
        break;
    }
  }
}

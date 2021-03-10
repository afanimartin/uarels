import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:timeago/timeago.dart' as timeago;

import '../models/models.dart';
import '../screens/article_details.dart';

class RenderUrl extends StatelessWidget {
  final Url url;
  final UserModel user;
  final Function(String value) handleClick;

  RenderUrl(
      {@required this.url,
      @required this.user,
      @required this.handleClick,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ArticleDetails(
                  url: url.inputUrl,
                  appBarTitle: url.title,
                ))),
        child: Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                    // Text(timeago.format(url.timestamp.toDate())),

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

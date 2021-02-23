import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const _avatarSize = 40.0;

class Avatar extends StatelessWidget {
  final String photoUrl;

  const Avatar({@required this.photoUrl, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            radius: _avatarSize,
            backgroundImage: photoUrl != null
                ? CachedNetworkImageProvider(
                    photoUrl,
                  )
                : null),
      );
}

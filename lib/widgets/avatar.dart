import 'package:flutter/material.dart';

const _avatarSize = 45.0;

class Avatar extends StatelessWidget {
  final String photoUrl;

  const Avatar({@required this.photoUrl, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: _avatarSize,
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
        child: photoUrl == null
            ? const Icon(
                Icons.person_outline,
                size: _avatarSize,
              )
            : null,
      );
}

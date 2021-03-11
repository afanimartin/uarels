import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../blocs/favorite_url/favorite_url_state.dart';
import 'progress_loader.dart';
import 'widgets.dart';

class FavoriteUrls extends StatefulWidget {
  const FavoriteUrls({Key key}) : super(key: key);

  @override
  _FavoriteUrlsState createState() => _FavoriteUrlsState();
}

class _FavoriteUrlsState extends State<FavoriteUrls> {
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

                  return RenderUrl(
                    url: url,
                    user: user,
                    key: const Key('favorite_urls'),
                  );
                });
      }

      return const Center(child: Text('Failed to connect to the server'));
    });
  }
}


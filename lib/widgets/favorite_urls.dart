import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../blocs/url/url_state.dart';
import 'progress_loader.dart';
import 'render_article.dart';

class FavoriteUrls extends StatelessWidget {
  const FavoriteUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<UrlBloc, UrlState>(builder: (context, state) {
      if (state is UrlsLoading || state is UrlAdding || state is UrlDeleting) {
        return const ProgressLoader();
      }

      if (state is UrlsUpdated) {
        return state.favoriteUrls.isEmpty
            ? const Center(child: Text('No favorite urls to load'))
            : ListView.builder(
                itemCount: state?.favoriteUrls?.length,
                itemBuilder: (context, index) {
                  final url = state.favoriteUrls[index];

                  return RenderArticle(
                    url: url,
                    user: user,
                    key: const Key('favorite_urls'),
                  );
                });
      }

      return const Text('');
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/url/url_bloc.dart';
import '../blocs/url/url_state.dart';
import 'progress_loader.dart';
import 'render_article.dart';

class PublicUrls extends StatelessWidget {
  const PublicUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<UrlBloc, UrlState>(builder: (context, state) {
      if (state is UrlsLoading ||
          state is UrlAdding ||
          state is UrlDeleting ||
          state is UrlUpdating) {
        return const ProgressLoader();
      }

      if (state is UrlsUpdated) {
        return state.publicUrls.isEmpty
            ? const Center(child: Text('No Urls to load'))
            : ListView.builder(
                itemCount: state?.publicUrls?.length,
                itemBuilder: (context, index) {
                  final url = state.publicUrls[index];

                  return RenderArticle(
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
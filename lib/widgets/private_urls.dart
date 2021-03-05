import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/public_url/public_url_state.dart';
import 'progress_loader.dart';
import 'render_article.dart';

class PrivateUrls extends StatelessWidget {
  const PrivateUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<PublicUrlBloc, PublicUrlState>(builder: (context, state) {
      if (state is PublicUrlsLoading || state is UrlAdding || state is UrlDeleting) {
        return const ProgressLoader();
      }

      if (state is PublicUrlsUpdated) {
        return state.privateUrls.isEmpty
            ? const Center(child: Text('No private urls to load'))
            : ListView.builder(
                itemCount: state?.privateUrls?.length,
                itemBuilder: (context, index) {
                  final url = state.privateUrls[index];

                  return RenderArticle(
                    url: url,
                    user: user,
                    key: const Key('private_urls'),
                  );
                });
      }

      return const Text('');
    });
  }
}

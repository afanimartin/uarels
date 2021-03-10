import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/public_url/public_url_bloc.dart';
import '../blocs/public_url/public_url_state.dart';
import 'progress_loader.dart';
import 'widgets.dart';

class PublicUrls extends StatelessWidget {
  const PublicUrls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<PublicUrlBloc, PublicUrlState>(
        builder: (context, state) {
      if (state is PublicUrlsLoading ||
          state is UrlAdding ||
          state is UrlDeleting ||
          state is SharingUrl) {
        return const ProgressLoader();
      }

      if (state is PublicUrlsUpdated) {
        return state.urls.isEmpty
            ? const Center(child: Text('No Urls to load'))
            : ListView.builder(
                itemCount: state?.urls?.length,
                itemBuilder: (context, index) {
                  final url = state.urls[index];

                  return RenderUrl(
                    url: url,
                    user: user,
                    handleClick: handleClick,
                    key: const Key('public_urls'),
                  );
                });
      }

      return const Text('');
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Add to favorites':
        // _favoriteUrlBloc.add(AddUrlToFavorites(url: url));
        break;

      default:
        break;
    }
  }
}

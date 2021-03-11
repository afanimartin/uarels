import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../blocs/private_url/private_url_state.dart';
import 'progress_loader.dart';
import 'render_url.dart';

class PrivateUrls extends StatefulWidget {
  const PrivateUrls({Key key}) : super(key: key);

  @override
  _PrivateUrlsState createState() => _PrivateUrlsState();
}

class _PrivateUrlsState extends State<PrivateUrls> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocBuilder<PrivateUrlBloc, PrivateUrlState>(
        builder: (context, state) {
      if (state is PrivateUrlsLoading || state is AddingUrlToPublic) {
        return const ProgressLoader();
      }

      if (state is PrivateUrlsUpdated) {
        return state.urls.isEmpty
            ? const Center(child: Text('No private urls to load'))
            : ListView.builder(
                itemCount: state?.urls?.length,
                itemBuilder: (context, index) {
                  final url = state.urls[index];

                  return RenderUrl(
                    user: user,
                    url: url,
                    key: const Key('private_urls'),
                  );
                });
      }

      return const Center(child: Text('Failed to connect to the server'));
    });
  }
}

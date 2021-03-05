import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../blocs/blocs.dart';
import '../blocs/public_url/public_url_state.dart';
import '../widgets/widgets.dart';

class ArticleDetails extends StatelessWidget {
  final String url;
  final String appBarTitle;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ArticleDetails({@required this.url, @required this.appBarTitle, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(appBarTitle),
        ),
        body: BlocBuilder<PublicUrlBloc, PublicUrlState>(
          builder: (context, state) {
            if (state == null) {
              return const ProgressLoader();
            }
            return WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            );
          },
        ),
      );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
          backgroundColor: Colors.cyan[700],
          title: Text(appBarTitle),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      );
}

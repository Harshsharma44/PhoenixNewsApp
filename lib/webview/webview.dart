import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Webview extends StatefulWidget {
  String url;
  Webview(this.url);


  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black

      ),
        home: Scaffold(
      appBar: AppBar(title: Text("Webview"),),
      body: Container(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewController){
            setState(() {
              controller.complete(webviewController);
            });
          },

        ),
      ),
    )
    );
  }
}

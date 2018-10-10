import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cool WebView',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WebView(url: 'https://flutter.io'),
    );
  }
}

class WebView extends StatefulWidget {
  WebView({Key key, this.url}) : super(key: key);

  final String url;

  @override
  WebViewState createState() => new WebViewState();
}

class WebViewState extends State<WebView> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();


  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text('まだまだな WebView'),
      ),
    );
  }
}

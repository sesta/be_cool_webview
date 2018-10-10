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
  bool _loading = false;
  final List<String> _history = <String>[];
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((url) {
      if (_history.length > 0 && url == _history.last) {
        return;
      }

      if (url != 'about:blank') {
        _history.add(url);
      }
    });

    flutterWebviewPlugin.onStateChanged.listen((data) {
      if (data.type.toString() == 'WebViewState.finishLoad') {
        setState(() {
          _loading = false;
        });
      }
      if (data.type.toString() == 'WebViewState.startLoad') {
        setState(() {
          _loading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text('いい感じな WebView'),
        bottom: PreferredSize(
          child: _buildLoadingBar(),
          preferredSize: null
        ),
      ),
      persistentFooterButtons: <Widget>[
        _buildBackButton(),
      ],
    );
  }

  Widget _buildLoadingBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SizedBox(
          width: double.infinity,
          height: 4.0,
          child: _loading ? LinearProgressIndicator() : null
      ),
    );
  }

  Widget _buildBackButton() {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(right: size.width - 56.0),
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _backUrl,
        ),
      ),
    );
  }

  void _backUrl() {
    if (_history.length <= 1) {
      return;
    }

    // 今見ているページの分を削除
    _history.removeLast();

    // 1つ前を取り出して削除
    final prevUrl = _history.removeLast();
    flutterWebviewPlugin.reloadUrl(prevUrl);
  }
}

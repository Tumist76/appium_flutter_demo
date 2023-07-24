import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenArguments {
  final Uri url;

  const WebViewScreenArguments({required this.url});
}

class WebViewScreen extends StatefulWidget {
  final Uri url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final webViewController = WebViewController();

  @override
  void initState() {
    webViewController.loadRequest(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поиск')),
      body: WebViewWidget(controller: webViewController),
    );
  }
}

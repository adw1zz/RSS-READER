import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    String url = data['url'];

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: InAppWebView(
            onWebViewCreated: (controller) => webViewController = controller,
            initialUrlRequest: URLRequest(
              url: Uri.parse(url),
            ),
          ),
        ),
      ],
    ));
  }
}

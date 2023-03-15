import 'package:flutter/material.dart';
import 'package:rss_reader/pages/pages.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const Loading(url: 'https://www.onliner.by/feed'),
    '/home': (context) => const Home(),
    '/webview': (context) => const WebViewScreen(),
  }));
}

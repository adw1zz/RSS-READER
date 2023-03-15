// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_reader/services/xml_parser.dart';
import 'package:rss_reader/services/news_model.dart';

class Loading extends StatefulWidget {
  final String url;

  const Loading({super.key, required this.url});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getNews() async {
    XmlParser parser = XmlParser();
    List<NewsModel> news = await parser.parseXml(widget.url);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'news': news,
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(26, 33, 33, 1),
        body: Center(
            child: SpinKitSpinningLines (
          color: Color.fromRGBO(98, 191, 225, 1),
          size: 60,
        )),
      ),
    );
  }
}

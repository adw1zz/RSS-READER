import 'dart:convert';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rss_reader/services/news_model.dart';
import 'package:xml/xml_events.dart';

class XmlParser {
  Future<List<NewsModel>> parseXml(String url) async {
    List<NewsModel> news = [];
    try {
      final inetCon = InternetConnectionChecker();
      bool isConnected = await inetCon.hasConnection;
      if (!isConnected) {
        news.add(NewsModel(
            newsTitle: 'no inet connection',
            newsUrl: 'dfh',
            newsPubDate: 'dfgdf'));
        return news;
      }
      final request = await HttpClient().getUrl(Uri.parse(url));
      final responce = await request.close();
      await responce
          .transform(utf8.decoder)
          .toXmlEvents()
          .selectSubtreeEvents((value) => value.name == 'item')
          .toXmlNodes()
          .expand((element) => element)
          .forEach((element) {
        String xml = element.innerXml;
        String link = xml.substring(
            xml.indexOf('<link>') + '<link>'.length, xml.indexOf('</link>'));
        String title = xml.substring(
            xml.indexOf('<title>') + '<![CDATA['.length + '<title>'.length,
            xml.indexOf('</title>') - ']]>'.length);
        String pubdate = xml.substring(
            xml.indexOf('<pubDate>') + '<pubDate>'.length,
            xml.indexOf('</pubDate>'));
        news.add(
            NewsModel(newsTitle: title, newsUrl: link, newsPubDate: pubdate));
      });
      return news;
    } catch (error) {
      return news;
    }
  }
}

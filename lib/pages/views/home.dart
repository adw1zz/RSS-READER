import 'package:flutter/material.dart';
import 'package:rss_reader/services/news_model.dart';
import 'package:rss_reader/pages/views/loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List<NewsModel> news = data['news'];

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 82, 101, 101),
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller: searchController,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Link",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(98, 191, 225, 1),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onSubmitted: (string) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Loading(
                            url: string,
                          )));
                },
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(26, 33, 33, 1),
          body: news.isNotEmpty && news[0].newsTitle == 'no inet connection'
              ? const Center(
                child: Text('No internet connection',
                    style:
                        TextStyle(color: Color.fromRGBO(98, 191, 225, 1)
                        )),
              )
              : ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                      child: ListTile(
                        tileColor: const Color.fromRGBO(0xde, 0xf2, 0xf1, 0.8),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromRGBO(0x17, 0x25, 0x2a, 1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/webview', arguments: {
                            'url': news[index].newsUrl,
                          });
                        },
                        title: Text(news[index].newsTitle,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0x17, 0x25, 0x2a, 1))),
                        subtitle: Text(
                          news[index].newsPubDate,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}

class NewsModel {
  String newsTitle;
  String newsUrl;
  String newsPubDate;

  NewsModel(
      {required this.newsTitle,
      required this.newsUrl,
      required this.newsPubDate});

  @override
  String toString() {
    return '$newsTitle\n$newsUrl\n$newsPubDate\n';
  }
}

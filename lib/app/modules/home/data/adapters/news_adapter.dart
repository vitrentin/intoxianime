import 'package:intoxianime/app/modules/home/data/model/news_model.dart';

class NewsAdapter {
  static NewsModel fromJson(dynamic e) {
    return NewsModel(
      id: e['id'] ?? 0,
      date: e['date'] ?? '',
      title: e['title']['rendered'] ?? '',
      urlImage: (e['og_image'] as List?)?.firstOrNull['url'] ??
          'https://img.freepik.com/premium-vector/colorful-winter-cartoon-anime-error-404-page-found_150972-721.jpg?w=740',
      aboutAnime: e['yoast_head'],
    );
  }

  static List<NewsModel> fromList(List list) {
    return list.map(NewsAdapter.fromJson).toList();
  }
}

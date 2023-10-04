import '../model/news_model.dart';

class NewsAdapter {
  static NewsModel fromJson(dynamic e) {
    return NewsModel(
      id: e['id'] ?? 0,
      date: e['date'] ?? '',
      title: e['title']['rendered'] ?? '',
      urlImage: (e['yoast_head_json']?['og_image'] as List?)
              ?.firstOrNull['url'] ??
          'https://img.freepik.com/premium-vector/colorful-winter-cartoon-anime-error-404-page-found_150972-721.jpg?w=740',
      aboutAnime: e['content']['rendered'] ?? '',
      description: e['yoast_head_json']['og_description'] ?? '',
      author: e['yoast_head_json']['author'] ?? '',
    );
  }

  static List<NewsModel> fromList(List list) {
    return list.map(NewsAdapter.fromJson).toList();
  }
}

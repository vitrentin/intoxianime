import 'package:dio/dio.dart';
import 'package:intoxianime/app/modules/home/data/adapters/news_adapter.dart';
import 'package:intoxianime/app/modules/home/data/model/news_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<NewsModel>> getAllNews() async {
    final response = await dio.get(
      'https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=1&per_page=10',
    );
    return NewsAdapter.fromList(response.data);
  }
}

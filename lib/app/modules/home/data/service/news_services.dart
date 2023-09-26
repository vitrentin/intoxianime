import 'package:dio/dio.dart';

import '../adapters/news_adapter.dart';
import '../model/news_model.dart';

class NewsService {
  final Dio _dio;

  const NewsService(this._dio);

  static const String _baseUrl = 'https://www.intoxianime.com/';

  static const perPage = 10;

  Future<List<NewsModel>> getAllNews([int offset = 0]) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'rest_route': '/wp/v2/posts',
        'page': (offset ~/ perPage) + 1,
        'per_page': perPage,
      },
    );
    return NewsAdapter.fromList(response.data);
  }
}

import 'package:flutter/material.dart';
import 'package:intoxianime/app/modules/home/presenter/states/news_state.dart';

import '../../data/service/news_services.dart';

class NewsStore extends ValueNotifier<NewsState> {
  final NewsService _service;

  NewsStore(this._service) : super(const NewsIdle());

  Future<void> fetchNewsInitial() async {
    if (value is! NewsIdle && value is! NewsLoaded) return;
    value = const NewsLoading();
    try {
      final news = await _service.getAllNews();
      value = NewsLoaded(news: news);
    } catch (e) {
      debugPrint(e.toString());
      value = NewsError(
        message: 'Ops, algo deu errado na sua consulta',
        error: e,
        news: value.news,
      );
    }
  }

  Future<void> fetchNews() async {
    if (value is! NewsLoaded) return;
    value = NewsLoadedWithLoading(news: value.news);
    try {
      final news = await _service.getAllNews(value.news.length);
      value = NewsLoaded(news: [...value.news, ...news]);
    } catch (e) {
      debugPrint(e.toString());
      value = NewsError(
        message: 'Ops, algo deu errado na sua consulta',
        error: e,
        news: value.news,
      );
    }
  }
}

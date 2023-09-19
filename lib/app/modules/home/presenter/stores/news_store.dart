import 'package:flutter/material.dart';

import '../../data/model/news_model.dart';
import '../../data/service/news_services.dart';

class NewsStore extends ChangeNotifier {
  final NewsService service;

  List<dynamic> news = <NewsModel>[];

  NewsStore(this.service);

  Future<void> fetchNews() async {
    news = await service.getAllNews();
    notifyListeners();
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/service/news_services.dart';

import 'presenter/pages/news_page.dart';
import 'presenter/stores/news_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..addInstance(Dio())
      ..add(NewsService.new)
      ..addSingleton(NewsStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const NewsPage());
  }
}

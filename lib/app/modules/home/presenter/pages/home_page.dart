import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intoxianime/app/modules/home/presenter/stores/news_store.dart';
import 'package:intoxianime/app/modules/home/presenter/widgets/background_with_circle_blur_widget.dart';
import 'package:intoxianime/app/modules/home/presenter/widgets/card_new_widget.dart';
import 'package:intoxianime/app/modules/home/presenter/widgets/traces_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<NewsStore>();

  @override
  void initState() {
    super.initState();
    store.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundWithCircleBlurWidget(),
        Scaffold(
          appBar: AppBar(
            title: const Text('Intoxi Anime'),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const TracesWidget(),
              ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) => const CardNewWidget(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 40),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

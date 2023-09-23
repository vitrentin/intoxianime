import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../states/news_state.dart';
import '../stores/news_store.dart';
import '../widgets/background_with_circle_blur_widget.dart';

import '../widgets/card_new_widget.dart';
import '../widgets/traces_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final store = Modular.get<NewsStore>();

  @override
  void initState() {
    super.initState();

    store.fetchNewsInitial();
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
              ListenableBuilder(
                listenable: store,
                builder: (context, _) {
                  final state = store.value;
                  return state.when(
                    idle: _IdleNewsPage.new,
                    error: _ErrorNewsPage.new,
                    loaded: _LoadedNewsPage.new,
                    loading: _LoadingNewsPage.new,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IdleNewsPage extends StatelessWidget {
  const _IdleNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ErrorNewsPage extends StatelessWidget {
  final NewsError state;
  const _ErrorNewsPage(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(state.message));
  }
}

class _LoadedNewsPage extends StatefulWidget {
  final NewsLoaded state;
  const _LoadedNewsPage(this.state, {Key? key}) : super(key: key);

  @override
  State<_LoadedNewsPage> createState() => _LoadedNewsPageState();
}

class _LoadedNewsPageState extends State<_LoadedNewsPage> {
  late final ScrollController _scrollController;
  final store = Modular.get<NewsStore>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
  }

  Future<void> infiniteScrolling() async {
    if (_scrollController.position.pixels + 100 >=
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      isLoading = true;
      await store.fetchNews();
      isLoading = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadedWithLoading = widget.state is NewsLoadedWithLoading;
    return Stack(
      children: [
        ListView.separated(
          controller: _scrollController,
          itemCount: widget.state.news.length,
          cacheExtent: 1000,
          padding: EdgeInsets.only(bottom: isLoadedWithLoading ? 40 : 0),
          itemBuilder: (context, index) =>
              CardNewWidget(news: widget.state.news[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 40),
        ),
        if (widget.state is NewsLoadedWithLoading)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}

class _LoadingNewsPage extends StatelessWidget {
  final NewsLoading state;
  const _LoadingNewsPage(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 32,
      ),
    );
  }
}

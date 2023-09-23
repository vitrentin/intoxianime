import '../../data/model/news_model.dart';

sealed class NewsState {
  final List<NewsModel> news;

  const NewsState({required this.news});

  T when<T>({
    required T Function() idle,
    T Function(NewsLoading state)? loading,
    T Function(NewsLoaded state)? loaded,
    T Function(NewsLoadedWithLoading state)? loadedWithLoading,
    T Function(NewsError state)? error,
  }) {
    return switch (this) {
      NewsIdle _ => idle(),
      final NewsLoading state => loading?.call(state) ?? idle(),
      final NewsLoaded state => loaded?.call(state) ?? idle(),
      final NewsError state => error?.call(state) ?? idle(),
    };
  }
}

class NewsIdle extends NewsState {
  const NewsIdle() : super(news: const []);
}

class NewsLoading extends NewsState {
  const NewsLoading() : super(news: const []);
}

class NewsLoaded extends NewsState {
  const NewsLoaded({required super.news});
}

class NewsLoadedWithLoading extends NewsLoaded {
  const NewsLoadedWithLoading({required super.news});
}

class NewsError extends NewsState {
  final String message;
  final dynamic error;

  const NewsError({
    super.news = const [],
    required this.message,
    required this.error,
  });
}

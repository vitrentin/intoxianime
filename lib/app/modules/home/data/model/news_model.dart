class NewsModel {
  final int id;
  final String date;
  final String title;
  final String urlImage;
  final String aboutAnime;

  const NewsModel({
    required this.id,
    required this.date,
    required this.title,
    required this.urlImage,
    required this.aboutAnime,
  });

  NewsModel copyWith({
    int? id,
    String? date,
    String? title,
    String? urlImage,
    String? aboutAnime,
  }) {
    return NewsModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      urlImage: urlImage ?? this.urlImage,
      aboutAnime: aboutAnime ?? this.urlImage,
    );
  }
}

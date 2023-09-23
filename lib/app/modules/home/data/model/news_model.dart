import 'package:intl/intl.dart';

class NewsModel {
  final int id;
  final String date;
  final String title;
  final String urlImage;
  final String aboutAnime;
  final String description;

  const NewsModel({
    required this.id,
    required this.date,
    required this.title,
    required this.urlImage,
    required this.aboutAnime,
    required this.description,
  });

  String get dateTime {
    final format = DateFormat('dd/MM/yyyy');
    return format.format(DateTime.parse(date));
  }

  NewsModel copyWith({
    int? id,
    String? date,
    String? title,
    String? urlImage,
    String? aboutAnime,
    String? description,
  }) {
    return NewsModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      urlImage: urlImage ?? this.urlImage,
      aboutAnime: aboutAnime ?? this.urlImage,
      description: description ?? this.description,
    );
  }
}

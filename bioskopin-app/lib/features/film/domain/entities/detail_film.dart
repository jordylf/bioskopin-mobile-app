// Package imports:
import 'package:equatable/equatable.dart';

class DetailFilm extends Equatable {
  final String id;
  final String title;
  final String genre;
  final String duration;
  final String description;
  final String image;
  final DateTime showTime;

  const DetailFilm({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.description,
    required this.image,
    required this.showTime,
  });

  @override
  List<Object> get props =>
      [id, title, genre, duration, description, image, showTime];
}

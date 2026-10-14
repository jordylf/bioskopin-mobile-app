// Package imports:
import 'package:equatable/equatable.dart';

class Film extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;

  const Film({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  List<Object> get props => [id, title, image, description];
}

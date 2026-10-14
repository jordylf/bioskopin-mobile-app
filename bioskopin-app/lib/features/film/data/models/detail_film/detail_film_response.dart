// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_film_response.g.dart';

@JsonSerializable()
class DetailFilmResponse extends Equatable {
  const DetailFilmResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  static const String statusKey = 'status';

  final Data? data;
  static const String dataKey = 'data';

  factory DetailFilmResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailFilmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailFilmResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

@JsonSerializable()
class Data extends Equatable {
  const Data({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.description,
    required this.image,
    required this.showtime,
  });

  final String? id;
  static const String idKey = 'id';

  final String? title;
  static const String titleKey = 'title';

  final String? genre;
  static const String genreKey = 'genre';

  final String? duration;
  static const String durationKey = 'duration';

  final String? description;
  static const String descriptionKey = 'description';

  final String? image;
  static const String imageKey = 'image';

  final DateTime? showtime;
  static const String showtimeKey = 'showtime';

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        genre,
        duration,
        description,
        image,
        showtime,
      ];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_film_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailFilmResponse _$DetailFilmResponseFromJson(Map<String, dynamic> json) =>
    DetailFilmResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailFilmResponseToJson(DetailFilmResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      title: json['title'] as String?,
      genre: json['genre'] as String?,
      duration: json['duration'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      showtime: json['showtime'] == null
          ? null
          : DateTime.parse(json['showtime'] as String),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'genre': instance.genre,
      'duration': instance.duration,
      'description': instance.description,
      'image': instance.image,
      'showtime': instance.showtime?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_film_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingFilmRequest _$BookingFilmRequestFromJson(Map<String, dynamic> json) =>
    BookingFilmRequest(
      filmId: json['film_id'] as String?,
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$BookingFilmRequestToJson(BookingFilmRequest instance) =>
    <String, dynamic>{
      'film_id': instance.filmId,
      'quantity': instance.quantity,
    };

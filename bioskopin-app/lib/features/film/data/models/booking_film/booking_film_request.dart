// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_film_request.g.dart';

@JsonSerializable()
class BookingFilmRequest extends Equatable {
  const BookingFilmRequest({
    required this.filmId,
    required this.quantity,
  });

  @JsonKey(name: 'film_id')
  final String? filmId;
  static const String filmIdKey = 'film_id';

  final String? quantity;
  static const String quantityKey = 'quantity';

  factory BookingFilmRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingFilmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookingFilmRequestToJson(this);

  @override
  List<Object?> get props => [
        filmId,
        quantity,
      ];
}

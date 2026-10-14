// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse extends Equatable {
  const BookingResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  static const String statusKey = 'status';

  final List<Datum>? data;
  static const String dataKey = 'data';

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

@JsonSerializable()
class Datum extends Equatable {
  const Datum({
    required this.id,
    required this.title,
    required this.ticketQuantity,
    required this.status,
    required this.createdAt,
  });

  final String? id;
  static const String idKey = 'id';

  final String? title;
  static const String titleKey = 'title';

  @JsonKey(name: 'ticket_quantity')
  final String? ticketQuantity;
  static const String ticketQuantityKey = 'ticket_quantity';

  final String? status;
  static const String statusKey = 'status';

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const String createdAtKey = 'created_at';

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        ticketQuantity,
        status,
        createdAt,
      ];
}

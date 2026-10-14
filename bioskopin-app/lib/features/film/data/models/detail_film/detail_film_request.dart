// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_film_request.g.dart';

@JsonSerializable()
class DetailFilmRequest extends Equatable {
  const DetailFilmRequest({
    required this.id,
  });

  final String? id;
  static const String idKey = 'id';

  factory DetailFilmRequest.fromJson(Map<String, dynamic> json) =>
      _$DetailFilmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DetailFilmRequestToJson(this);

  @override
  List<Object?> get props => [
        id,
      ];
}

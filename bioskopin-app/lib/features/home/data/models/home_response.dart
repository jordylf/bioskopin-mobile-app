// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse extends Equatable {
  const HomeResponse({
    required this.status,
    required this.data,
  });

  final String? status;
  static const String statusKey = 'status';

  final List<Datum>? data;
  static const String dataKey = 'data';

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

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
    required this.image,
    required this.description,
  });

  final String? id;
  static const String idKey = 'id';

  final String? title;
  static const String titleKey = 'title';

  final String? image;
  static const String imageKey = 'image';

  final String? description;
  static const String descriptionKey = 'description';

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        description,
      ];
}

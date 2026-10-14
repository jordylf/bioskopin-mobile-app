// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest extends Equatable {
  const EditProfileRequest({
    required this.fullname,
    required this.email,
  });

  final String? fullname;
  static const String fullnameKey = 'fullname';

  final String? email;
  static const String emailKey = 'email';

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);

  @override
  List<Object?> get props => [
        fullname,
        email,
      ];
}

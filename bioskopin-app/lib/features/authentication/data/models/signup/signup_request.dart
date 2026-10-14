// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest extends Equatable {
  const SignupRequest({
    required this.fullname,
    required this.email,
    required this.password,
  });

  final String? fullname;
  static const String fullnameKey = 'fullname';

  final String? email;
  static const String emailKey = 'email';

  final String? password;
  static const String passwordKey = 'password';

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @override
  List<Object?> get props => [
        fullname,
        email,
        password,
      ];
}

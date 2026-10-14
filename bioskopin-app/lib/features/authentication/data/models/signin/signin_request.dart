// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_request.g.dart';

@JsonSerializable()
class SigninRequest extends Equatable {
  const SigninRequest({
    required this.email,
    required this.password,
  });

  final String? email;
  static const String emailKey = 'email';

  final String? password;
  static const String passwordKey = 'password';

  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

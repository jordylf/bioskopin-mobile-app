// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_response.g.dart';

@JsonSerializable()
class SigninResponse extends Equatable {
  const SigninResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.data,
  });

  final String? status;
  static const String statusKey = 'status';

  final String? message;
  static const String messageKey = 'message';

  final String? token;
  static const String tokenKey = 'token';

  final Data? data;
  static const String dataKey = 'data';

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        message,
        token,
        data,
      ];
}

@JsonSerializable()
class Data extends Equatable {
  const Data({
    required this.fullname,
    required this.email,
  });

  final String? fullname;
  static const String fullnameKey = 'fullname';

  final String? email;
  static const String emailKey = 'email';

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [
        fullname,
        email,
      ];
}

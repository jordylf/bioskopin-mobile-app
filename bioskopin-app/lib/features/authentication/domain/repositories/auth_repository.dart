// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_request.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_response.dart';
import 'package:bioskopin/features/authentication/data/models/signup/signup_request.dart';

abstract class AuthRepository {
  Future<Either<DioException, SigninResponse>> signin(
    SigninRequest request,
  );

  Future<Either<DioException, void>> signup(
    SignupRequest request,
  );

  Future<User?> getUser();

  Future<void> saveUser(User user);

  Future<void> removeUser();
}

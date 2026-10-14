// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/authentication/data/datasources/remote/auth_api_service.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_request.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_response.dart';
import 'package:bioskopin/features/authentication/data/models/signup/signup_request.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalService _authLocalService;
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authLocalService, this._authApiService);

  @override
  Future<Either<DioException, SigninResponse>> signin(
    SigninRequest request,
  ) async {
    try {
      final data = SigninRequest(
        email: request.email,
        password: request.password,
      );

      final http = await _authApiService.signIn(data);

      if (http.response.statusCode == HttpStatus.ok) {
        return Right(http.data);
      } else {
        return Left(
          DioException(
            error: http.response.statusMessage,
            response: http.response,
            type: DioExceptionType.badResponse,
            requestOptions: http.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DioException, void>> signup(
    SignupRequest request,
  ) async {
    try {
      final data = SignupRequest(
        fullname: request.fullname,
        email: request.email,
        password: request.password,
      );

      final http = await _authApiService.signUp(data);

      if (http.response.statusCode == HttpStatus.ok) {
        return Right(http.data);
      } else {
        return Left(
          DioException(
            error: http.response.statusMessage,
            response: http.response,
            type: DioExceptionType.badResponse,
            requestOptions: http.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<User?> getUser() async {
    return await _authLocalService.getUser();
  }

  @override
  Future<void> saveUser(User user) async {
    await _authLocalService.saveUser(user);
  }

  @override
  Future<void> removeUser() async {
    await _authLocalService.removeUser();
  }
}

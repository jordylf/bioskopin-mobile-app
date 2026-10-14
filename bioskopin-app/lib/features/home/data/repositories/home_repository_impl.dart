// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/home/data/datasources/remote/home_api_service.dart';
import 'package:bioskopin/features/home/data/models/home_response.dart';
import 'package:bioskopin/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService _homeApiService;
  final AuthLocalService _authLocalService;

  HomeRepositoryImpl(this._homeApiService, this._authLocalService);

  @override
  Future<Either<DioException, HomeResponse>> home() async {
    try {
      final user = await _authLocalService.getUser();

      final http = await _homeApiService.home('Bearer ${user?.token}');

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
}

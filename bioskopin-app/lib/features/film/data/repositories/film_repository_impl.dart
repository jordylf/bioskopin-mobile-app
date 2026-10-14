// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/film/data/datasources/remote/film_api_service.dart';
import 'package:bioskopin/features/film/data/models/booking_film/booking_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_response.dart';
import 'package:bioskopin/features/film/domain/repositories/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmApiService _filmApiService;
  final AuthLocalService _authLocalService;

  FilmRepositoryImpl(this._filmApiService, this._authLocalService);

  @override
  Future<Either<DioException, DetailFilmResponse>> detailFilm(
    DetailFilmRequest request,
  ) async {
    try {
      final user = await _authLocalService.getUser();

      final http = await _filmApiService.detailFilm(
        request.id ?? '',
        'Bearer ${user?.token}',
      );

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
  Future<Either<DioException, void>> bookingFilm(
    BookingFilmRequest request,
  ) async {
    try {
      final user = await _authLocalService.getUser();

      final data = BookingFilmRequest(
        filmId: request.filmId,
        quantity: request.quantity,
      );

      final http =
          await _filmApiService.bookingFilm(data, 'Bearer ${user?.token}');

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

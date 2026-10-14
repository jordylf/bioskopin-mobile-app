// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/booking/data/datasources/remote/booking_api_service.dart';
import 'package:bioskopin/features/booking/data/models/booking_response.dart';
import 'package:bioskopin/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingApiService _bookingApiService;
  final AuthLocalService _authLocalService;

  BookingRepositoryImpl(this._bookingApiService, this._authLocalService);

  @override
  Future<Either<DioException, BookingResponse>> booking() async {
    try {
      final user = await _authLocalService.getUser();

      final http = await _bookingApiService.home('Bearer ${user?.token}');

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

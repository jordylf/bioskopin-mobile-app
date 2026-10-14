// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/booking/data/models/booking_response.dart';

abstract class BookingRepository {
  Future<Either<DioException, BookingResponse>> booking();
}

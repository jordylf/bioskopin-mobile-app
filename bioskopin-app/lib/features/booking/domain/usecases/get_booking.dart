// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/booking/data/models/booking_response.dart';
import 'package:bioskopin/features/booking/domain/repositories/booking_repository.dart';

class GetBookingUseCase
    implements UseCase<NoParams, Either<DioException, BookingResponse>> {
  final BookingRepository _bookingRepository;

  GetBookingUseCase(this._bookingRepository);

  @override
  Future<Either<DioException, BookingResponse>> call({
    NoParams? request,
  }) async {
    return await _bookingRepository.booking();
  }
}

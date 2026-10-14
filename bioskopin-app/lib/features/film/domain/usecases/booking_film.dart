// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/film/data/models/booking_film/booking_film_request.dart';
import 'package:bioskopin/features/film/domain/repositories/film_repository.dart';

class BookingFilmUseCase
    implements UseCase<BookingFilmRequest, Either<DioException, void>> {
  final FilmRepository _filmRepository;

  BookingFilmUseCase(this._filmRepository);

  @override
  Future<Either<DioException, void>> call({
    BookingFilmRequest? request,
  }) async {
    if (request == null) {
      return Left(
        DioException(
          error: 'Request cannot be null',
          response: null,
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }

    return await _filmRepository.bookingFilm(request);
  }
}

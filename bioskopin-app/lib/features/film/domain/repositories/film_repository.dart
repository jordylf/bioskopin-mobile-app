// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/film/data/models/booking_film/booking_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_response.dart';

abstract class FilmRepository {
  Future<Either<DioException, DetailFilmResponse>> detailFilm(
    DetailFilmRequest request,
  );

  Future<Either<DioException, void>> bookingFilm(
    BookingFilmRequest request,
  );
}

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_response.dart';
import 'package:bioskopin/features/film/domain/repositories/film_repository.dart';

class GetDetailFilmUseCase
    implements
        UseCase<DetailFilmRequest, Either<DioException, DetailFilmResponse>> {
  final FilmRepository _filmRepository;

  GetDetailFilmUseCase(this._filmRepository);

  @override
  Future<Either<DioException, DetailFilmResponse>> call({
    DetailFilmRequest? request,
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

    return await _filmRepository.detailFilm(request);
  }
}

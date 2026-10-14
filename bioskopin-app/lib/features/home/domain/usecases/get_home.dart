// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/home/data/models/home_response.dart';
import 'package:bioskopin/features/home/domain/repositories/home_repository.dart';

class GetHomeUseCase
    implements UseCase<NoParams, Either<DioException, HomeResponse>> {
  final HomeRepository _homeRepository;

  GetHomeUseCase(this._homeRepository);

  @override
  Future<Either<DioException, HomeResponse>> call({
    NoParams? request,
  }) async {
    return await _homeRepository.home();
  }
}

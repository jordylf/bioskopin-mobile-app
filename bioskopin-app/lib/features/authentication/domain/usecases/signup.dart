// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/authentication/data/models/signup/signup_request.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class SignupUseCase
    implements UseCase<SignupRequest, Either<DioException, void>> {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  @override
  Future<Either<DioException, void>> call({
    SignupRequest? request,
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

    return await _authRepository.signup(request);
  }
}

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_request.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_response.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class SigninUseCase
    implements UseCase<SigninRequest, Either<DioException, SigninResponse>> {
  final AuthRepository _authRepository;

  SigninUseCase(this._authRepository);

  @override
  Future<Either<DioException, SigninResponse>> call({
    SigninRequest? request,
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

    return await _authRepository.signin(request);
  }
}

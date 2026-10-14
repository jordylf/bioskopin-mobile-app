// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/profile/data/models/edit_profile_request.dart';
import 'package:bioskopin/features/profile/domain/repositories/profile_repository.dart';

class EditProfileUseCase
    implements UseCase<EditProfileRequest, Either<DioException, void>> {
  final ProfileRepository _profileRepository;

  EditProfileUseCase(this._profileRepository);

  @override
  Future<Either<DioException, void>> call({
    EditProfileRequest? request,
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

    return await _profileRepository.editProfile(request);
  }
}

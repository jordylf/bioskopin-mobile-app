// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/profile/data/datasources/remote/profile_api_service.dart';
import 'package:bioskopin/features/profile/data/models/edit_profile_request.dart';
import 'package:bioskopin/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;
  final AuthLocalService _authLocalService;

  ProfileRepositoryImpl(this._profileApiService, this._authLocalService);

  @override
  Future<Either<DioException, void>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final user = await _authLocalService.getUser();

      final data = EditProfileRequest(
        fullname: request.fullname,
        email: request.email,
      );

      final http =
          await _profileApiService.editProfile(data, 'Bearer ${user?.token}');

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

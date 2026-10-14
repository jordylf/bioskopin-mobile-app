// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/profile/data/models/edit_profile_request.dart';

abstract class ProfileRepository {
  Future<Either<DioException, void>> editProfile(
    EditProfileRequest request,
  );
}

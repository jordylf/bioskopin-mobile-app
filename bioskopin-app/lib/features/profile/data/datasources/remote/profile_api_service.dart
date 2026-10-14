// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/profile/data/models/edit_profile_request.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @PUT('/profile/update.php')
  Future<HttpResponse<void>> editProfile(
    @Body() EditProfileRequest request,
    @Header('Authorization') String token,
  );
}

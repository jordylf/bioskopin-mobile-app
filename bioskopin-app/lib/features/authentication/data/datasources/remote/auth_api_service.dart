// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_request.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_response.dart';
import 'package:bioskopin/features/authentication/data/models/signup/signup_request.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/auth/login.php')
  Future<HttpResponse<SigninResponse>> signIn(
    @Body() SigninRequest request,
  );

  @POST('/auth/register.php')
  Future<HttpResponse<void>> signUp(
    @Body() SignupRequest request,
  );
}

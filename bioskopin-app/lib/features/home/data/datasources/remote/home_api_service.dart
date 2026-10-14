// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/home/data/models/home_response.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET('/film/get.php')
  Future<HttpResponse<HomeResponse>> home(
    @Header('Authorization') String token,
  );
}

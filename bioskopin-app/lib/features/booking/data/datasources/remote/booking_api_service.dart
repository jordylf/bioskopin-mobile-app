// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/booking/data/models/booking_response.dart';

part 'booking_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class BookingApiService {
  factory BookingApiService(Dio dio) = _BookingApiService;

  @GET('/booking/get.php')
  Future<HttpResponse<BookingResponse>> home(
    @Header('Authorization') String token,
  );
}

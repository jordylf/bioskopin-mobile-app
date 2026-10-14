// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/film/data/models/booking_film/booking_film_request.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_response.dart';

part 'film_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class FilmApiService {
  factory FilmApiService(Dio dio) = _FilmApiService;

  @GET('/film/detail.php')
  Future<HttpResponse<DetailFilmResponse>> detailFilm(
    @Query('id') String id,
    @Header('Authorization') String token,
  );

  @POST('/booking/create.php')
  Future<HttpResponse<void>> bookingFilm(
    @Body() BookingFilmRequest request,
    @Header('Authorization') String token,
  );
}

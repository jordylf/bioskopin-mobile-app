// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bioskopin/features/home/data/models/home_response.dart';

abstract class HomeRepository {
  Future<Either<DioException, HomeResponse>> home();
}

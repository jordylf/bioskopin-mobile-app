// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/home/domain/entities/film.dart';
import 'package:bioskopin/features/home/domain/usecases/get_home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeUseCase _getHomeUseCase;

  HomeBloc(this._getHomeUseCase) : super(HomeInitial()) {
    on<GetHomeData>(onGetHomeData);
  }

  Future<void> onGetHomeData(
    GetHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());

      final response = await _getHomeUseCase.call();

      response.fold((error) {
        if (error.response?.statusCode == HttpStatus.requestTimeout) {
          emit(const HomeFailure(message: errorTimeout));
        } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
          emit(const HomeFailure(message: errorTooManyRequests));
        } else if (error.response?.statusCode ==
            HttpStatus.internalServerError) {
          emit(const HomeFailure(message: errorServer));
        } else if (error.response?.statusCode == HttpStatus.badGateway) {
          emit(const HomeFailure(message: errorBadGateway));
        } else if (error.response?.statusCode ==
            HttpStatus.serviceUnavailable) {
          emit(
            const HomeFailure(
              message: errorServiceUnavailable,
            ),
          );
        } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
          emit(const HomeFailure(message: errorGatewayTimeout));
        } else {
          emit(const HomeFailure(message: errorDefault));
        }
      }, (response) {
        final film = response.data
                ?.map(
                  (e) => Film(
                    id: e.id ?? '',
                    title: e.title ?? '',
                    image: e.image ?? '',
                    description: e.description ?? '',
                  ),
                )
                .toList() ??
            [];

        emit(HomeLoaded(films: film));
      });
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }
}

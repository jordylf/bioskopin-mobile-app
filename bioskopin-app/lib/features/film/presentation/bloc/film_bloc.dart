// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/film/data/models/detail_film/detail_film_request.dart';
import 'package:bioskopin/features/film/domain/entities/detail_film.dart';
import 'package:bioskopin/features/film/domain/usecases/get_detail_film.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final GetDetailFilmUseCase _getDetailFilmUseCase;

  FilmBloc(this._getDetailFilmUseCase) : super(FilmInitial()) {
    on<GetFilmData>(onGetFilmData);
  }

  Future<void> onGetFilmData(
    GetFilmData event,
    Emitter<FilmState> emit,
  ) async {
    try {
      emit(FilmLoading());

      final request = DetailFilmRequest(id: event.id);

      final response = await _getDetailFilmUseCase.call(request: request);

      response.fold((error) {
        if (error.response?.statusCode == HttpStatus.requestTimeout) {
          emit(FilmFailure(message: errorTimeout));
        } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
          emit(FilmFailure(message: errorTooManyRequests));
        } else if (error.response?.statusCode ==
            HttpStatus.internalServerError) {
          emit(FilmFailure(message: errorServer));
        } else if (error.response?.statusCode == HttpStatus.badGateway) {
          emit(FilmFailure(message: errorBadGateway));
        } else if (error.response?.statusCode ==
            HttpStatus.serviceUnavailable) {
          emit(
            FilmFailure(
              message: errorServiceUnavailable,
            ),
          );
        } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
          emit(FilmFailure(message: errorGatewayTimeout));
        } else if (error.response?.statusCode == HttpStatus.notFound) {
          emit(FilmFailure(message: 'Film tidak ditemukan'));
        } else {
          emit(FilmFailure(message: errorDefault));
        }
      }, (response) {
        final detail = DetailFilm(
          id: response.data?.id ?? '',
          title: response.data?.title ?? '',
          genre: response.data?.genre ?? '',
          duration: response.data?.duration ?? '',
          description: response.data?.description ?? '',
          image: response.data?.image ?? '',
          showTime: response.data?.showtime ?? DateTime.now(),
        );

        emit(FilmLoaded(detail: detail));
      });
    } catch (e) {
      emit(FilmFailure(message: e.toString()));
    }
  }
}

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/film/data/models/booking_film/booking_film_request.dart';
import 'package:bioskopin/features/film/domain/usecases/booking_film.dart';

part 'booking_film_state.dart';

class BookingFilmCubit extends Cubit<BookingFilmState> {
  final BookingFilmUseCase _bookingFilmUseCase;

  BookingFilmCubit(this._bookingFilmUseCase) : super(BookingFilmInitial());

  Future<void> onBookingFilm({
    required String id,
    required String ticketCount,
  }) async {
    try {
      emit(BookingFilmLoading());

      final request = BookingFilmRequest(filmId: id, quantity: ticketCount);

      final response = await _bookingFilmUseCase.call(request: request);

      response.fold((error) {
        if (error.response?.statusCode == HttpStatus.requestTimeout) {
          emit(BookingFilmFailure(message: errorTimeout));
        } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
          emit(BookingFilmFailure(message: errorTooManyRequests));
        } else if (error.response?.statusCode ==
            HttpStatus.internalServerError) {
          emit(BookingFilmFailure(message: errorServer));
        } else if (error.response?.statusCode == HttpStatus.badGateway) {
          emit(BookingFilmFailure(message: errorBadGateway));
        } else if (error.response?.statusCode ==
            HttpStatus.serviceUnavailable) {
          emit(
            BookingFilmFailure(
              message: errorServiceUnavailable,
            ),
          );
        } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
          emit(BookingFilmFailure(message: errorGatewayTimeout));
        } else {
          emit(BookingFilmFailure(message: errorDefault));
        }
      }, (response) {
        emit(BookingFilmSuccess());
      });
    } catch (e) {
      emit(BookingFilmFailure(message: e.toString()));
    }
  }
}

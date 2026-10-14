// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/core/enums/booking_status.dart';
import 'package:bioskopin/features/booking/domain/entities/booking.dart';
import 'package:bioskopin/features/booking/domain/usecases/get_booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookingUseCase _getBookingUseCase;

  BookingBloc(this._getBookingUseCase) : super(BookingInitial()) {
    on<GetBookingData>(onGetBookingData);
  }

  Future<void> onGetBookingData(
    GetBookingData event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(BookingLoading());

      final response = await _getBookingUseCase.call();

      response.fold((error) {
        if (error.response?.statusCode == HttpStatus.requestTimeout) {
          emit(const BookingFailure(message: errorTimeout));
        } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
          emit(const BookingFailure(message: errorTooManyRequests));
        } else if (error.response?.statusCode ==
            HttpStatus.internalServerError) {
          emit(const BookingFailure(message: errorServer));
        } else if (error.response?.statusCode == HttpStatus.badGateway) {
          emit(const BookingFailure(message: errorBadGateway));
        } else if (error.response?.statusCode ==
            HttpStatus.serviceUnavailable) {
          emit(
            const BookingFailure(
              message: errorServiceUnavailable,
            ),
          );
        } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
          emit(const BookingFailure(message: errorGatewayTimeout));
        } else {
          emit(const BookingFailure(message: errorDefault));
        }
      }, (response) {
        final booking = response.data
                ?.map(
                  (e) => Booking(
                    id: e.id ?? '',
                    title: e.title ?? '',
                    ticketQty: e.ticketQuantity ?? '',
                    status: BookingStatus.values.firstWhere(
                      (status) =>
                          status.toString().split('.').last ==
                          e.status.toString().toLowerCase(),
                      orElse: () => BookingStatus.pending,
                    ),
                    date: e.createdAt ?? DateTime.now(),
                  ),
                )
                .toList() ??
            [];

        emit(BookingLoaded(bookings: booking));
      });
    } catch (e) {
      emit(BookingFailure(message: e.toString()));
    }
  }
}

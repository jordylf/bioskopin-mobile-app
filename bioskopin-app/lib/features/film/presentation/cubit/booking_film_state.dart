part of 'booking_film_cubit.dart';

sealed class BookingFilmState extends Equatable {
  const BookingFilmState();

  @override
  List<Object> get props => [];
}

final class BookingFilmInitial extends BookingFilmState {}

final class BookingFilmLoading extends BookingFilmState {}

final class BookingFilmSuccess extends BookingFilmState {}

final class BookingFilmFailure extends BookingFilmState {
  final String message;

  const BookingFilmFailure({required this.message});

  @override
  List<Object> get props => [message];
}

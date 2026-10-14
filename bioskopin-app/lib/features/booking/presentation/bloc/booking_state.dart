part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  final List<Booking> bookings;

  const BookingState({this.bookings = const []});

  @override
  List<Object> get props => [bookings];
}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingLoaded extends BookingState {
  const BookingLoaded({required super.bookings});

  @override
  List<Object> get props => [bookings];
}

final class BookingFailure extends BookingState {
  final String message;

  const BookingFailure({required this.message});

  @override
  List<Object> get props => [message];
}

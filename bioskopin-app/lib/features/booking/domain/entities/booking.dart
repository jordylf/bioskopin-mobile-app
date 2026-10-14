// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/enums/booking_status.dart';

class Booking extends Equatable {
  final String id;
  final String title;
  final String ticketQty;
  final BookingStatus status;
  final DateTime date;

  const Booking({
    required this.id,
    required this.title,
    required this.ticketQty,
    required this.status,
    required this.date,
  });

  @override
  List<Object> get props => [id, title, ticketQty, status, date];
}

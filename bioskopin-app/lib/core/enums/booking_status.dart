enum BookingStatus {
  pending,
  confirmed,
  canceled,
}

extension BookingStatusExtension on BookingStatus {
  String get name {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Dikonfirmasi';
      case BookingStatus.canceled:
        return 'Dibatalkan';
    }
  }
}

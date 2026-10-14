// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bioskopin/core/enums/booking_status.dart';
import 'package:bioskopin/core/utils/format_date.dart';
import 'package:bioskopin/core/widgets/card.dart';

class BookingCard extends StatelessWidget {
  final String title;
  final String bookingCount;
  final DateTime date;
  final BookingStatus status;

  const BookingCard({
    super.key,
    required this.title,
    required this.bookingCount,
    required this.date,
    required this.status,
  });

  Color getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.canceled:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Jumlah Pesanan: $bookingCount',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Tanggal Pemesanan: ${FormatDateUtil.formatDateTime(date.toIso8601String())}',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Status: ${status.name}',
              style: TextStyle(
                fontSize: 12.0,
                color: getStatusColor(status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

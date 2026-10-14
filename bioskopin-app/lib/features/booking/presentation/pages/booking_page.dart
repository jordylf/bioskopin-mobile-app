// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bioskopin/features/booking/presentation/widgets/booking_card.dart';
import 'package:bioskopin/features/booking/presentation/widgets/booking_card_skeleton.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingBloc>()..add(GetBookingData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pemesanan'),
        ),
        body: SafeArea(
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state is BookingLoading) {
                return ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) => const BookingCardSkeleton(),
                );
              } else if (state is BookingLoaded) {
                if (state.bookings.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada data pemesanan'),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<BookingBloc>().add(GetBookingData());
                    },
                    child: ListView.builder(
                      itemCount: state.bookings.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (context, index) {
                        final booking = state.bookings[index];

                        return BookingCard(
                          title: booking.title,
                          bookingCount: booking.ticketQty,
                          date: booking.date,
                          status: booking.status,
                        );
                      },
                    ),
                  );
                }
              } else if (state is BookingFailure) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

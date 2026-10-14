// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/core/utils/form_validator.dart';
import 'package:bioskopin/core/utils/format_date.dart';
import 'package:bioskopin/core/widgets/button.dart';
import 'package:bioskopin/core/widgets/input.dart';
import 'package:bioskopin/core/widgets/overlay_loader.dart';
import 'package:bioskopin/features/film/presentation/cubit/booking_film_cubit.dart';

class BookingFilmArgs {
  final String id;
  final String name;
  final DateTime showTime;

  const BookingFilmArgs({
    required this.id,
    required this.name,
    required this.showTime,
  });
}

class BookingFilmPage extends HookWidget {
  final BookingFilmArgs args;

  const BookingFilmPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final ticketCountController = useTextEditingController();

    return BlocProvider(
      create: (context) => sl<BookingFilmCubit>(),
      child: BlocListener<BookingFilmCubit, BookingFilmState>(
        listener: (context, state) {
          if (state is BookingFilmSuccess) {
            context.go('/booking');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[700],
                content: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Pemesanan berhasil!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10.0),
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (state is BookingFilmFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[700],
                content: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10.0),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pemesanan Tiket Film'),
          ),
          body: BlocBuilder<BookingFilmCubit, BookingFilmState>(
            builder: (context, state) {
              return SafeArea(
                child: OverlayLoader(
                  isLoading: state is BookingFilmLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Judul Film',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            args.name,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Tanggal Tayang',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            FormatDateUtil.formatDateTime(
                              args.showTime.toIso8601String(),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                CustomInput(
                                  label: 'Jumlah tiket yang akan dipesan',
                                  controller: ticketCountController,
                                  hint: 'Jumlah Tiket',
                                  inputType: TextInputType.number,
                                  validator: FormValidator.validateTicket,
                                ),
                                const SizedBox(height: 30.0),
                                CustomButton(
                                  label: 'Pesan Sekarang',
                                  borderRadius: 10.0,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      context
                                          .read<BookingFilmCubit>()
                                          .onBookingFilm(
                                            id: args.id,
                                            ticketCount:
                                                ticketCountController.text,
                                          );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

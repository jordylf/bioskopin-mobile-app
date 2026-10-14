// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/features/home/presentation/bloc/home_bloc.dart';
import 'package:bioskopin/features/home/presentation/widgets/film_card.dart';
import 'package:bioskopin/features/home/presentation/widgets/film_card_skeleton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(GetHomeData()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
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
            title: const Text('Beranda Bioskopin'),
          ),
          body: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return ListView.builder(
                    itemCount: 5,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) => const FilmCardSkeleton(),
                  );
                } else if (state is HomeLoaded) {
                  if (state.films.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada film yang tersedia'),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(GetHomeData());
                      },
                      child: ListView.builder(
                        itemCount: state.films.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (context, index) {
                          final film = state.films[index];

                          return FilmCard(
                            imageUrl: film.image,
                            title: film.title,
                            description: film.description,
                            onTap: () {
                              context.push('/film/${film.id}');
                            },
                          );
                        },
                      ),
                    );
                  }
                } else if (state is HomeFailure) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

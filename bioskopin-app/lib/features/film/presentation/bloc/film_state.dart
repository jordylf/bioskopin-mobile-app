part of 'film_bloc.dart';

abstract class FilmState extends Equatable {
  final DetailFilm detail;

  FilmState({
    DetailFilm? detail,
  }) : detail = detail ??
            DetailFilm(
              id: '',
              title: '',
              genre: '',
              duration: '',
              description: '',
              image: '',
              showTime: DateTime(1970, 1, 1),
            );

  @override
  List<Object> get props => [detail];
}

final class FilmInitial extends FilmState {}

final class FilmLoading extends FilmState {}

final class FilmLoaded extends FilmState {
  FilmLoaded({required super.detail});

  @override
  List<Object> get props => [detail];
}

final class FilmFailure extends FilmState {
  final String message;

  FilmFailure({required this.message});

  @override
  List<Object> get props => [message];
}

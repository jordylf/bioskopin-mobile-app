part of 'film_bloc.dart';

abstract class FilmEvent extends Equatable {
  const FilmEvent();

  @override
  List<Object> get props => [];
}

final class GetFilmData extends FilmEvent {
  final String id;

  const GetFilmData({required this.id});

  @override
  List<Object> get props => [id];
}

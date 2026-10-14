part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<Film> films;

  const HomeState({this.films = const []});

  @override
  List<Object> get props => [films];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required super.films});

  @override
  List<Object> get props => [films];
}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}

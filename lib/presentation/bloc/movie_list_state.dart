part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListHasData extends MovieListState {
  final List<Movie> movies;

  const MovieListHasData({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final bool isAddedToWatchList;

  const MovieDetailLoaded({
    required this.movie,
    this.isAddedToWatchList = false,
  });

  MovieDetailLoaded copyWith(
      {MovieDetail? movie,
      List<Movie>? recommendationMovies,
      bool? isAddedToWatchList}) {
    return MovieDetailLoaded(
        movie: movie ?? this.movie,
        isAddedToWatchList: this.isAddedToWatchList);
  }

  @override
  List<Object> get props => [movie, isAddedToWatchList];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  const MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}


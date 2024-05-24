part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlisLoading extends MovieWatchlistState {}

class MovieWatchlisLoaded extends MovieWatchlistState {
  final List<Movie> watchlistMovies;

  const MovieWatchlisLoaded({required this.watchlistMovies});

  @override
  List<Object> get props => watchlistMovies;
}

class MovieWatchListError extends MovieWatchlistState {
  final String message;
  const MovieWatchListError({required this.message});
  @override
  List<Object> get props => [message];
}

class MovieWatchListSuccess extends MovieWatchlistState {
  final String message;
  const MovieWatchListSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

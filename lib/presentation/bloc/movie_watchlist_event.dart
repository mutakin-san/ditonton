part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchListMovie extends MovieWatchlistEvent {}

class AddMovieToWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  const AddMovieToWatchList({required this.movie});
}

class RemoveMovieFromWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveMovieFromWatchList({required this.movie});
}

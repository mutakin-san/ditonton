part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail({required this.id});
}

class LoadMovieWatchListStatus extends MovieDetailEvent {
  final int id;

  const LoadMovieWatchListStatus({required this.id});
}

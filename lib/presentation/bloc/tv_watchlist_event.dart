part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}



class LoadWatchListTv extends TvWatchlistEvent {}

class AddTvToWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  const AddTvToWatchList({required this.tv});
}

class RemoveTvFromWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  const RemoveTvFromWatchList({required this.tv});
}

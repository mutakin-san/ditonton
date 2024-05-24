part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlisLoading extends TvWatchlistState {}

class TvWatchlisLoaded extends TvWatchlistState {
  final List<Tv> watchlistTvs;

  const TvWatchlisLoaded({required this.watchlistTvs});

  @override
  List<Object> get props => watchlistTvs;
}

class TvWatchListError extends TvWatchlistState {
  final String message;
  const TvWatchListError({required this.message});
  @override
  List<Object> get props => [message];
}

class TvWatchListSuccess extends TvWatchlistState {
  final String message;
  const TvWatchListSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

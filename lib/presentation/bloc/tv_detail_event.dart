part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;

  const FetchTvDetail({required this.id});
}

class LoadTvWatchListStatus extends TvDetailEvent {
  final int id;

  const LoadTvWatchListStatus({required this.id});
}

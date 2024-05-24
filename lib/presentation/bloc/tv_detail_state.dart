part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tv;
  final bool isAddedToWatchList;

  const TvDetailLoaded({
    required this.tv,
    this.isAddedToWatchList = false,
  });

  TvDetailLoaded copyWith(
      {TvDetail? movie,
      List<Tv>? recommendationTvs,
      bool? isAddedToWatchList}) {
    return TvDetailLoaded(
        tv: movie ?? tv, isAddedToWatchList: this.isAddedToWatchList);
  }

  @override
  List<Object> get props => [tv, isAddedToWatchList];
}

class TvDetailError extends TvDetailState {
  final String message;
  const TvDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> listTv;

  const TopRatedTvLoaded(this.listTv);

  @override
  List<Object> get props => [listTv];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;
  const TopRatedTvError(this.message);
  @override
  List<Object> get props => [message];
}

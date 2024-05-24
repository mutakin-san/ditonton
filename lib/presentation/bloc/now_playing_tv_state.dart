part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvEmpty extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<Tv> listTv;

  const NowPlayingTvLoaded(this.listTv);

  @override
  List<Object> get props => [listTv];
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;
  const NowPlayingTvError(this.message);
  @override
  List<Object> get props => [message];
}

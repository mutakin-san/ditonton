part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> listTv;

  const PopularTvLoaded(this.listTv);

  @override
  List<Object> get props => [listTv];
}

class PopularTvError extends PopularTvState {
  final String message;
  const PopularTvError(this.message);
  @override
  List<Object> get props => [message];
}

part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override
  List<Object> get props => [];
}

class TvRecommendationInitial extends TvRecommendationState {}
class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationLoaded extends TvRecommendationState {
  final List<Tv> tvRecommendations;
  const TvRecommendationLoaded({required this.tvRecommendations});
  @override
  List<Object> get props => [tvRecommendations];
}

class TvRecommendationError extends TvRecommendationState {
  final String message;
  const TvRecommendationError({required this.message});
  @override
  List<Object> get props => [message];
}

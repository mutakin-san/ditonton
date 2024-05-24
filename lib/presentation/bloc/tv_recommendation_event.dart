part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationTv extends TvRecommendationEvent {
  final int id;

  const FetchRecommendationTv({required this.id});
}

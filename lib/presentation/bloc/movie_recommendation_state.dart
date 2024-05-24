part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movieRecommendations;
  const MovieRecommendationLoaded({required this.movieRecommendations});
  @override
  List<Object> get props => [movieRecommendations];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;
  const MovieRecommendationError({required this.message});
  @override
  List<Object> get props => [message];
}

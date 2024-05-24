import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(MovieRecommendationEmpty()) {
    on<FetchRecommendationMovie>((event, emit) async {
      emit(MovieRecommendationLoading());
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(MovieRecommendationError(message: failure.message));
        },
        (movies) {
          emit(MovieRecommendationLoaded(movieRecommendations: movies));
        },
      );
    });
  }
}

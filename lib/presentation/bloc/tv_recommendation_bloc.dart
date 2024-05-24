import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvSeriesRecommendations getTvRecommendations;

  TvRecommendationBloc({required this.getTvRecommendations})
      : super(TvRecommendationInitial()) {
    on<FetchRecommendationTv>((event, emit) async {
      emit(TvRecommendationLoading());
      final recommendationResult = await getTvRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(TvRecommendationError(message: failure.message));
        },
        (tvs) {
          emit(TvRecommendationLoaded(tvRecommendations: tvs));
        },
      );
    });
  }
}

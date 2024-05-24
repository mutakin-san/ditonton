import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchListStatus,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final isAddedToWatchlist = await getWatchListStatus.execute(event.id);

      detailResult.fold((failure) {
        emit(MovieDetailError(message: failure.message));
      }, (movie) async {
        emit(MovieDetailLoaded(
            movie: movie, isAddedToWatchList: isAddedToWatchlist));
      });

    });
  }
}

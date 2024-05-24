import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchList;

  MovieWatchlistBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchList,
  }) : super(MovieWatchlistInitial()) {
    on<LoadWatchListMovie>((event, emit) async {
      emit(MovieWatchlisLoading());
      final result = await getWatchList.execute();

      await result.fold(
        (failure) async {
          emit(MovieWatchListError(message: failure.message));
        },
        (movies) async {
          emit(MovieWatchlisLoaded(watchlistMovies: movies));
        },
      );
    });

    on<AddMovieToWatchList>((event, emit) async {
      emit(MovieWatchlisLoading());
      final result = await saveWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(MovieWatchListError(message: failure.message));
        },
        (successMessage) async {
          emit(MovieWatchListSuccess(message: successMessage));
        },
      );
    });

    on<RemoveMovieFromWatchList>((event, emit) async {
      emit(MovieWatchlisLoading());
      final result = await removeWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(MovieWatchListError(message: failure.message));
        },
        (successMessage) async {
          emit(MovieWatchListSuccess(message: successMessage));
        },
      );
    });
  }
}

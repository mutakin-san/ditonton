import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTVWatchlist removeWatchlist;
  final GetWatchlistTVSeries getWatchList;

  TvWatchlistBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchList,
  }) : super(TvWatchlistInitial()) {
    on<LoadWatchListTv>((event, emit) async {
      emit(TvWatchlisLoading());
      final result = await getWatchList.execute();

      await result.fold(
        (failure) async {
          emit(TvWatchListError(message: failure.message));
        },
        (tvs) async {
          emit(TvWatchlisLoaded(watchlistTvs: tvs));
        },
      );
    });

    on<AddTvToWatchList>((event, emit) async {
      emit(TvWatchlisLoading());
      final result = await saveWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(TvWatchListError(message: failure.message));
        },
        (successMessage) async {
          emit(TvWatchListSuccess(message: successMessage));
        },
      );
    });

    on<RemoveTvFromWatchList>((event, emit) async {
      emit(TvWatchlisLoading());
      final result = await removeWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(TvWatchListError(message: failure.message));
        },
        (successMessage) async {
          emit(TvWatchListSuccess(message: successMessage));
        },
      );
    });
  }
}

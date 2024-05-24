import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvDetail;
  final GetTVWatchListStatus getWatchListStatus;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getWatchListStatus,
  }) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final detailResult = await getTvDetail.execute(event.id);
      final isAddedToWatchList = await getWatchListStatus.execute(event.id);

      detailResult.fold((failure) {
        emit(TvDetailError(message: failure.message));
      }, (tv) {
        emit(TvDetailLoaded(tv: tv, isAddedToWatchList: isAddedToWatchList));
      });

    });

  }
}

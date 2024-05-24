import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  NowPlayingTvBloc(GetNowPlayingTvSeries useCase) : super(NowPlayingTvEmpty()) {
    on<FetchNowPlayingTv>((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await useCase.execute();

      result.fold((error) => emit(NowPlayingTvError(error.message)),
          (tv) => emit(NowPlayingTvLoaded(tv)));
    });
  }
}

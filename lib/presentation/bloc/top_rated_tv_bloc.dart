import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  TopRatedTvBloc(GetTopRatedTvSeries useCase) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await useCase.execute();

      result.fold((error) => emit(TopRatedTvError(error.message)),
          (listTv) => emit(TopRatedTvLoaded(listTv)));
    });
  }
}

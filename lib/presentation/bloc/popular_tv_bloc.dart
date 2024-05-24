import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  PopularTvBloc(GetPopularTvSeries useCase) : super(PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final result = await useCase.execute();

      result.fold((error) => emit(PopularTvError(error.message)),
          (tvs) => emit(PopularTvLoaded(tvs)));
    });
  }
}

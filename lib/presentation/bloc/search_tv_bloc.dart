import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeries _searchTvSeries;
  SearchTvBloc(this._searchTvSeries) : super(SearchTvEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());

      final result = await _searchTvSeries.execute(query);

      result.fold((failure) {
        emit(SearchTvError(failure.message));
      }, (data) => emit(SearchTvHasData(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

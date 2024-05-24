import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(GetTopRatedMovies useCase) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await useCase.execute();

      result.fold((error) => emit(TopRatedMoviesError(error.message)),
          (movies) => emit(TopRatedMoviesLoaded(movies)));
    });
  }
}

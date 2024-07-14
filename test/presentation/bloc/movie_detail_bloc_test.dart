import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetWatchListStatus])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();

    movieDetailBloc = MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail,
        getWatchListStatus: mockGetWatchListStatus);
  });

  test('initial state should be empty',
      () => expect(movieDetailBloc.state, MovieDetailEmpty()));

  const tId = 1;


  blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, HasData] when get detail movie data is gotten successfully.',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            const MovieDetailLoaded(movie: testMovieDetail)
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
  blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when get now playing moviesget detail movie is unsuccessful.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            const MovieDetailError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/movies/movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();

    movieListBloc = MovieListBloc(
        mockGetNowPlayingMovies, mockGetPopularMovies, mockGetTopRatedMovies);
  });

  test('initial state should be empty',
      () => expect(movieListBloc.state, MovieListEmpty()));

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, HasData] when now playing movies data is gotten successfully.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            MovieListHasData(movies: tMovieList)
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, HasData] when popular movies data is gotten successfully.',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            MovieListHasData(movies: tMovieList)
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, HasData] when top rated movies data is gotten successfully.',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            MovieListHasData(movies: tMovieList)
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when get now playing movies is unsuccessful.',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            const MovieListError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when get popular movies is unsuccessful.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            const MovieListError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
  blocTest<MovieListBloc, MovieListState>(
      'emits [Loading, Error] when get top rated movies is unsuccessful.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieListState>[
            MovieListLoading(),
            const MovieListError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}

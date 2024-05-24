import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';


@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;

  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();

    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  test('initial state should be empty',
      () => expect(popularMoviesBloc.state, PopularMoviesEmpty()));

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
  final tPopularMovies = <Movie>[tMovieModel];

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [Loading, HasData] when popular movies data is gotten successfully.',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tPopularMovies));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <PopularMoviesState>[
            PopularMoviesLoading(),
            PopularMoviesLoaded(tPopularMovies)
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [Loading, Error] when get popular movies is unsuccessful.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <PopularMoviesState>[
            PopularMoviesLoading(),
            const PopularMoviesError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
}

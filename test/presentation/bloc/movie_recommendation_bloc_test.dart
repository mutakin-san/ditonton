import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendation_bloc_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;

  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();

    movieRecommendationBloc =
        MovieRecommendationBloc(getMovieRecommendations: mockGetMovieRecommendations);
  });

  test('initial state should be empty',
      () => expect(movieRecommendationBloc.state, MovieRecommendationEmpty()));

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
  final tMovieRecommendations = <Movie>[tMovieModel];

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'emits [Loading, HasData] when top rated tv data is gotten successfully.',
      build: () {
        when(mockGetMovieRecommendations.execute(100))
            .thenAnswer((_) async => Right(tMovieRecommendations));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationMovie(id: 100)),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieRecommendationState>[
            MovieRecommendationLoading(),
            MovieRecommendationLoaded(movieRecommendations: tMovieRecommendations)
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(100));
      });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'emits [Loading, Error] when get top rated tv is unsuccessful.',
      build: () {
        when(mockGetMovieRecommendations.execute(100)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationMovie(id: 100)),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieRecommendationState>[
            MovieRecommendationLoading(),
            const MovieRecommendationError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(100));
      });
}

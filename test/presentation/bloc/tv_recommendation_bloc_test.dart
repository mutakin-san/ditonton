import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recommendation_bloc_test.mocks.dart';


@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;

  late MockGetTvSeriesRecommendations mockGetTvRecommendation;

  setUp(() {
    mockGetTvRecommendation = MockGetTvSeriesRecommendations();

    tvRecommendationBloc =
        TvRecommendationBloc(getTvRecommendations: mockGetTvRecommendation);
  });

  test('initial state should be empty',
      () => expect(tvRecommendationBloc.state, TvRecommendationInitial()));

  final tTvModel = Tv(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tRecommendedTv = <Tv>[tTvModel];

  blocTest<TvRecommendationBloc, TvRecommendationState>(
      'emits [Loading, HasData] when top rated tv data is gotten successfully.',
      build: () {
        when(mockGetTvRecommendation.execute(100))
            .thenAnswer((_) async => Right(tRecommendedTv));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTv(id: 100)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvRecommendationState>[
            TvRecommendationLoading(),
            TvRecommendationLoaded(tvRecommendations: tRecommendedTv)
          ],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(100));
      });

  blocTest<TvRecommendationBloc, TvRecommendationState>(
      'emits [Loading, Error] when get top rated tv is unsuccessful.',
      build: () {
        when(mockGetTvRecommendation.execute(100)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTv(id: 100)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvRecommendationState>[
            TvRecommendationLoading(),
            const TvRecommendationError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(100));
      });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';


@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvBloc popularTvBloc;

  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();

    popularTvBloc = PopularTvBloc(mockGetPopularTvSeries);
  });

  test('initial state should be empty',
      () => expect(popularTvBloc.state, PopularTvEmpty()));

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
  final tTvList = <Tv>[tTvModel];
  blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, HasData] when popular tv data is gotten successfully.',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          <PopularTvState>[PopularTvLoading(), PopularTvLoaded(tTvList)],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });

  blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, Error] when get popular tv is unsuccessful.',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <PopularTvState>[
            PopularTvLoading(),
            const PopularTvError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });
}

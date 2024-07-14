import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvBloc topRatedTvBloc;

  late MockGetTopRatedTvSeries mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTvSeries();

    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be empty',
      () => expect(topRatedTvBloc.state, TopRatedTvEmpty()));

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
  final tTopRatedTv = <Tv>[tTvModel];

  blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [Loading, HasData] when top rated tv data is gotten successfully.',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTopRatedTv));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <TopRatedTvState>[
            TopRatedTvLoading(),
            TopRatedTvLoaded(tTopRatedTv)
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [Loading, Error] when get top rated tv is unsuccessful.',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <TopRatedTvState>[
            TopRatedTvLoading(),
            const TopRatedTvError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });
}

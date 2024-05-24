import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTvSeries();

    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('initial state should be empty',
      () => expect(nowPlayingTvBloc.state, NowPlayingTvEmpty()));

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

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'emits [Loading, HasData] when now playing tv data is gotten successfully.',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <NowPlayingTvState>[
            NowPlayingTvLoading(),
            NowPlayingTvLoaded(tTvList)
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });
  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'emits [Loading, Error] when get now playing tv is unsuccessful.',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <NowPlayingTvState>[
            NowPlayingTvLoading(),
            const NowPlayingTvError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      });
}

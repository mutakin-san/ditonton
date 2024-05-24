import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail, GetTVWatchListStatus])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvShowDetail mockGetTvDetail;
  late MockGetTVWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetTvDetail = MockGetTvShowDetail();
    mockGetWatchListStatus = MockGetTVWatchListStatus();

    tvDetailBloc = TvDetailBloc(
        getTvDetail: mockGetTvDetail,
        getWatchListStatus: mockGetWatchListStatus);
  });

  test('initial state should be empty',
      () => expect(tvDetailBloc.state, TvDetailEmpty()));

  const tId = 1;

  blocTest<TvDetailBloc, TvDetailState>(
      'emits [Loading, HasData] when get detail tv data is gotten successfully.',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvShowDetail));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvDetailState>[
            TvDetailLoading(),
            const TvDetailLoaded(tv: testTvShowDetail)
          ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      });
  blocTest<TvDetailBloc, TvDetailState>(
      'emits [Loading, Error] when get now playing tvsget detail tv is unsuccessful.',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvDetailState>[
            TvDetailLoading(),
            const TvDetailError(message: 'Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries, SaveTvSeriesWatchlist, RemoveTVWatchlist])
void main() {
  late TvWatchlistBloc bloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    bloc = TvWatchlistBloc(
      getWatchList: mockGetWatchlistTVSeries,
      saveWatchlist: mockSaveTvSeriesWatchlist,
      removeWatchlist: mockRemoveTVWatchlist,
    );
  });
  blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [Loading, HasData] when movies watchlist data is gotten successfully.',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right(testTvSeries));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchListTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvWatchlistState>[
            TvWatchlisLoading(),
            TvWatchlisLoaded(watchlistTvs: testTvSeries)
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
      });
  blocTest<TvWatchlistBloc, TvWatchlistState>(
      'emits [Loading, Error] when movies watchlist data is gotten unsuccessful.',
      build: () {
        when(mockGetWatchlistTVSeries.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't get data")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchListTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => <TvWatchlistState>[
            TvWatchlisLoading(),
            const TvWatchListError(message: "Can't get data")
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
      });
}

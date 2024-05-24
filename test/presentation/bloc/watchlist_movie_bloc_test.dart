import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieWatchlistBloc(
      getWatchList: mockGetWatchlistMovies,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [Loading, HasData] when movies watchlist data is gotten successfully.',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchListMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieWatchlistState>[
            MovieWatchlisLoading(),
            MovieWatchlisLoaded(watchlistMovies: testMovieList)
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });
  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [Loading, Error] when movies watchlist data is gotten unsuccessful.',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't get data")));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchListMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => <MovieWatchlistState>[
            MovieWatchlisLoading(),
            const MovieWatchListError(message: "Can't get data")
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });
}

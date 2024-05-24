import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();

    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty',
      () => expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty()));

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
  final tNowPlayingMovies = <Movie>[tMovieModel];

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'emits [Loading, HasData] when now playing movies data is gotten successfully.',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tNowPlayingMovies));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <NowPlayingMoviesState>[
            NowPlayingMoviesLoading(),
            NowPlayingMoviesLoaded(tNowPlayingMovies)
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'emits [Loading, Error] when get now playing movies is unsuccessful.',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => <NowPlayingMoviesState>[
            NowPlayingMoviesLoading(),
            const NowPlayingMoviesError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}

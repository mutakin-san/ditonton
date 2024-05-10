import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvBloc = SearchTvBloc(mockSearchTvSeries);
  });

  test('initial state should be empty',
      () => expect(searchTvBloc.state, SearchTvEmpty()));

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
  const tQuery = 'spiderman';

  blocTest<SearchTvBloc, SearchTvState>(
      'emits [Loading, HasData] when data is gotten successfully.',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => <SearchTvState>[SearchTvLoading(), SearchTvHasData(tTvList)],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      });

  blocTest<SearchTvBloc, SearchTvState>(
      'emits [Loading, Error] when get search is unsuccessful.',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          <SearchTvState>[SearchTvLoading(), const SearchTvError('Server Failure')],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      });
}

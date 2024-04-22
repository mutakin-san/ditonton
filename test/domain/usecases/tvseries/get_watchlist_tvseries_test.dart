import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVSeries usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTVSeries(mockTVRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeries));
  });
}

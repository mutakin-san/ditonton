import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTVWatchlist usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveTVWatchlist(mockTVRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTvShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}

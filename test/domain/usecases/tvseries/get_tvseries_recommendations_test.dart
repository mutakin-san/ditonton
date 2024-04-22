import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTvSeriesRecommendations(mockTVRepository);
  });

  const tId = 1;
  final tvSeries = <Tv>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTVRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tvSeries));
  });
}

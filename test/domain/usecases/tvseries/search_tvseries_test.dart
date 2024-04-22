import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTvSeries(mockTVRepository);
  });

  final tvSeries = <Tv>[];
  const tQuery = 'Spiderman';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTVRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tvSeries));
  });
}

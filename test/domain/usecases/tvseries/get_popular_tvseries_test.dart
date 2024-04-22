import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTVRepository mockTvSeriesRpository;

  setUp(() {
    mockTvSeriesRpository = MockTVRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRpository);
  });

  final tvSeries = <Tv>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRpository.getPopularTv())
            .thenAnswer((_) async => Right(tvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvSeries));
      });
    });
  });
}

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tvShowModel = TvModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tvShow = Tv(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tvShowModel.toEntity();
    expect(result, tvShow);
  });


  test('should return a Json map containing proper data', () {
    final result = tvShowModel.toJson();
    const expectedJsonMap = {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_name": 'originalTitle',
      "overview": 'overview',
      "popularity": 1.0,
      "poster_path": 'posterPath',
      "release_date": 'releaseDate',
      "name": 'title',
      "vote_average": 1.0,
      "vote_count": 1,
    };
    expect(result, expectedJsonMap);
  });


  test('should return model from JSON', () {
    const jsonMap = {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_name": 'originalTitle',
      "overview": 'overview',
      "popularity": 1.0,
      "poster_path": 'posterPath',
      "release_date": 'releaseDate',
      "name": 'title',
      "vote_average": 1.0,
      "vote_count": 1
    };
    final result = TvModel.fromJson(jsonMap);
    expect(result, tvShowModel);
  });
}

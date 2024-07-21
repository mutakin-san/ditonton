import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tvDetailModel = TVDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 2,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 5.5,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    runtime: [0, 0, 0],
    status: 'status',
    tagline: 'tagline',
    homepage: 'homepage',
    originalLanguage: 'originalLanguage',
  );

  const tvDetailJson = {
    "id": 1,
    "name": "name",
    "overview": "overview",
    "poster_path": "posterPath",
    "vote_average": 1.0,
    "vote_count": 1,
    "backdrop_path": "backdropPath",
    "number_of_episodes": 12,
    "number_of_seasons": 2,
    "original_name": "originalName",
    "original_language": "originalLanguage",
    "status": "status",
    "tagline": "tagline",
    "homepage": "homepage",
    "genres": [],
    "popularity": 5.5,
    "episode_run_time": [0, 0, 0],
    "adult": false,
  };

  test('should be a subclass of TvDetail entity', () async {
    final result = tvDetailModel.toEntity();
    expect(result, isA<TvDetail>());
  });


  test('should return a JSON map containing proper data', () {
    final result = tvDetailModel.toJson();
    expect(result, tvDetailJson);
  });


  test('should return tv detail model from JSON', () {
    final result = TVDetailResponse.fromJson(tvDetailJson);
    expect(result, tvDetailModel);
  });
}
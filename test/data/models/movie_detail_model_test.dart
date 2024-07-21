import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testMovieDetailResponseJson = {
    "adult": true,
    "backdrop_path": "backdropPath",
    "budget": 1,
    "genres": [
      {
        "id": 1,
        "name": "Action"
      }
    ],
    "homepage": "homepage",
    "id": 1,
    "imdb_id": "imdbId",
    "original_language": "originalLanguage",
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 1,
    "poster_path": "posterPath",
    "release_date": "releaseDate",
    "revenue": 1,
    "runtime": 1,
    "status": "status",
    "tagline": "tagline",
    "title": "title",
    "video": false,
    "vote_average": 1,
    "vote_count": 1
  };

  test('should be a subclass of MovieDetail Entity', () {
    const movieDetailResponse = MovieDetailResponse(
      adult: true,
      backdropPath: 'backdropPath',
      genres: [
        GenreModel(
          id: 1,
          name: 'Action',
        ),
      ],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 1,
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
      video: false,
      status: 'status',
      revenue: 1,
      budget: 1,
      tagline: 'tagline',
      homepage: 'homepage',
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
    );

    expect(movieDetailResponse.toEntity(), isA<MovieDetail>());
  });

  test('should return a JSON map containing proper data', () {
    
    final result = MovieDetailResponse.fromJson(testMovieDetailResponseJson).toJson();
    expect(result, testMovieDetailResponseJson);
  });


  test('should return movie detail model from json', () {
    final result = MovieDetailResponse.fromJson(testMovieDetailResponseJson);
    const moveDetailResponse = MovieDetailResponse(
      adult: true,
      backdropPath: 'backdropPath',
      genres: [
        GenreModel(
          id: 1,
          name: 'Action',
        ),
      ],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 1,
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
      video: false,
      status: 'status',
      revenue: 1,
      budget: 1,
      tagline: 'tagline',
      homepage: 'homepage',
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
    );

    expect(result, moveDetailResponse);
  });
}
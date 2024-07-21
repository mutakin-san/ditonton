import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final movieTableJson =  {
      'id': 1,
      'overview': 'overview',
      'posterPath': 'posterPath',
      'title': 'title',
    };

  const movieTable = MovieTable(
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      title: 'title',
    );

  test('should be a subclass of MovieTable entity', () async {
    final result = movieTable.toEntity();

    expect(result, isA<Movie>());
  });

  test('should return a JSON map containing proper data', () {
    final result =  movieTable.toJson();
    
    expect(result,movieTableJson);
  });


  test('should return movie table from JSON', () {
    final result = MovieTable.fromMap(movieTableJson);

    expect(result, movieTable);
  });
}
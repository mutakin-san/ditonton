import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const genreModel = GenreModel(
    id: 1,
    name: 'Action',
  );
  test('should be a subclass of Genre entity', () async {
    final result = genreModel.toEntity();
    expect(result, isA<Genre>());
  });

  test('should return a JSON map containing proper data', () {
    final result = genreModel.toJson();
    expect(result, {
      'id': 1,
      'name': 'Action',
    });
  });

  test('should return a genre model from json', () {
    final result = GenreModel.fromJson(genreModel.toJson());
    expect(result, genreModel);
  });
}
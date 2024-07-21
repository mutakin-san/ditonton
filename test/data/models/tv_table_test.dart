import 'package:ditonton/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    final Map<String, dynamic> jsonMap = {
      "id": 1,
      "title": "name",
      "overview": "overview",
      "posterPath": "posterPath",
    };

  const tTvTable = TvTable(
    id: 1,
    title: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  test('should return a valid model from JSON', () {
    final result = TvTable.fromMap(jsonMap);
    expect(result, equals(tTvTable));
  });

  test('should return a JSON map containing proper data', (){
    final result = tTvTable.toJson();
    expect(result, jsonMap);
  });
}
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tMovieTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be json form MovieTable', () async {
    // assert
    final result = tMovieTable.toJson();
    // act
    expect(result, tMovieTableJson);
  });
}

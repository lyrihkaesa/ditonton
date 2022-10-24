import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';

void main() {
  // arrange
  const tMovieTable = MovieTable(
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

import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  final tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );
  final tGenreModelJson = {
    "id": 1,
    "name": 'name',
  };

  test('should convert toJson', () async {
    // assert
    final result = tGenreModel.toJson();
    // act
    expect(result, tGenreModelJson);
  });
}

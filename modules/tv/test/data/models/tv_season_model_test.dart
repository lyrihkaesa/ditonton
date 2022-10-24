import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  test('should be json form TVSeasonModel', () async {
    // assert
    final result = testTVSeasonModel.toJson();
    // act
    expect(result, testTVSeasonModelJson);
  });

  test('should be entitiy TVSeason form TVSeasonModel', () async {
    // assert
    final result = testTVSeasonModel.toEntity();
    // act
    expect(result, testTVSeason);
  });
}

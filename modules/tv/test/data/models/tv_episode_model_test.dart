import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  test('should be json form TVSeasonModel', () async {
    // assert
    final result = testTVEpisodeModel.toJson();
    // act
    expect(result, testTVEpisodeModelJson);
  });

  test('equal TV Episode model', () async {
    expect(testTVEpisodeModel != testTVEpisodeModel2, true);
  });
}

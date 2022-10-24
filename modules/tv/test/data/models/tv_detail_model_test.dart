import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  test('should be json form TVDetailResponse', () async {
    // assert
    final result = testTVDetailResponse.toJson();
    // act
    expect(result, testTVDetailResponseJson);
  });
}

import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    // assert
    final result = testTVModel.toEntity();
    // act
    expect(result, testTV);
  });
}

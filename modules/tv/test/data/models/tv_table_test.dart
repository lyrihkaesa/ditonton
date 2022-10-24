import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  test('should be json form TVTable', () async {
    // assert
    final result = testTVTable.toJson();
    // act
    expect(result, testTVTableJson);
  });
}

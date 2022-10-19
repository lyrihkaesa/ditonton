import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVTable = TVTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTVTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be json form TVTable', () async {
    // assert
    final result = tTVTable.toJson();
    // act
    expect(result, tTVTableJson);
  });
}

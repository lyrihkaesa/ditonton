import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTVs(mockTVRepository);
  });

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTVs())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}

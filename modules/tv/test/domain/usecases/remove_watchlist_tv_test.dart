import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late RemoveWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTV(mockTVRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTVDetail)).thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}

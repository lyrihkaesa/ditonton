import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_season_detail_tv.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetSeasonDetailTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetSeasonDetailTV(mockTVRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  test('should get TVSeasonDetail from the repository', () async {
    // arrange
    when(mockTVRepository.getSeasonDetailTV(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(testTVSeasonDetail));
  });
}

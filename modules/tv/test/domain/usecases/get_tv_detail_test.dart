import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVDetail(mockTVRepository);
  });

  const tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTVDetail(tId)).thenAnswer((_) async => const Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTVDetail));
  });
}

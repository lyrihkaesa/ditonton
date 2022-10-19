import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today_tvs.dart';
import 'package:ditonton/presentation/provider/tv/airing_today_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTVs])
void main() {
  late MockGetAiringTodayTVs mockGetAiringTodayTVs;
  late AiringTodayTVsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTVs = MockGetAiringTodayTVs();
    notifier = AiringTodayTVsNotifier(mockGetAiringTodayTVs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVList = <TV>[tTV];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetAiringTodayTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchAiringTodayTVs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetAiringTodayTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchAiringTodayTVs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetAiringTodayTVs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchAiringTodayTVs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}

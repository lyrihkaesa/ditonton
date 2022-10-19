import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tvs.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks(
    [GetAiringTodayTVs, GetOnTheAirTVs, GetPopularTVs, GetTopRatedTVs])
void main() {
  late TVListNotifier provider;
  late MockGetAiringTodayTVs mockGetAiringTodayTVs;
  late MockGetOnTheAirTVs mockGetOnTheAirTVs;
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTVs = MockGetAiringTodayTVs();
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    mockGetOnTheAirTVs = MockGetOnTheAirTVs();
    provider = TVListNotifier(
      getAiringTodayTVs: mockGetAiringTodayTVs,
      getPopularTVs: mockGetPopularTVs,
      getTopRatedTVs: mockGetTopRatedTVs,
      getOnTheAirTVs: mockGetOnTheAirTVs,
    )..addListener(() {
        listenerCallCount += 1;
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
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
  );
  final tTVList = <TV>[tTV];

  group('airing today tvs', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchAiringTodayTVs();
      // assert
      verify(mockGetAiringTodayTVs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchAiringTodayTVs();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchAiringTodayTVs();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTVs();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('on the air tvs', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      verify(mockGetOnTheAirTVs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loaded);
      expect(provider.popularTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loaded);
      expect(provider.topRatedTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('On The Air TVs', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenAnswer((_) async => testTVModelList);
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Airing Today TVs', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs()).thenAnswer((_) async => testTVModelList);
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TVs', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenAnswer((_) async => testTVModelList);
      // act
      final result = await repository.getPopularTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TVs', () {
    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenAnswer((_) async => testTVModelList);
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Detail', () {
    const tId = 1;

    test('should return TV data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenAnswer((_) async => testTVDetailResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Right(testTVDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TVs Recommendations', () {
    final tTVList = <TVModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId)).thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TVs', () {
    const tQuery = 'spiderman';

    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenAnswer((_) async => testTVModelList);
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Season Detail TV', () {
    const int tId = 1;
    const int tSeasonNumber = 1;

    test('should return SeasonDetailTV when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber)).thenAnswer((_) async => testTVSeasonDetailModel);
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => testTVSeasonDetail);
      expect(resultList, equals(testTVSeasonDetail));
      expect(result, equals(Right(testTVSeasonDetailModel.toEntity())));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber)).thenThrow(ServerException());
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable)).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable)).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tvs', () {
    test('should return list of TVs', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVs()).thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchlistTVs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_episode_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper.mocks.dart';

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

  final tTVModel = TVModel(
    backdropPath: '/path.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Mahoka',
    overview: 'Overview',
    popularity: 60.441,
    posterPath: '/path.jpg',
    firstAirDate: '2002-09-09',
    name: 'Mahoka',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTV = TV(
    backdropPath: '/path.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Mahoka',
    overview: 'Overview',
    popularity: 60.441,
    posterPath: '/path.jpg',
    firstAirDate: '2002-09-09',
    name: 'Mahoka',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('On The Air TVs', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Airing Today TVs', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs()).thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTVs();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVs());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TVs', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TVs', () {
    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Detail', () {
    final tId = 1;
    final tTVResponse = TVDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      seasons: [],
      firstAirDate: 'firstAirDate',
      status: 'Status',
      tagline: 'Tagline',
      name: 'name',
      inProduction: false,
      voteAverage: 1,
      voteCount: 1,
      episodeRuntime: [1, 2],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
    );

    test('should return TV data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenAnswer((_) async => tTVResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTVDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TVs Recommendations', () {
    final tTVList = <TVModel>[];
    final tId = 1;

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
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TVs', () {
    final tQuery = 'spiderman';

    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Season Detail TV', () {
    final tTVEpisode = TVEpisode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 10,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1,
    );

    final tTVSeasonDetail = TVSeasonDetail(
      airDate: 'airDate',
      episodes: [tTVEpisode],
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    );
    final tTVEpisodeModel = TVEpisodeModel(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 10,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1,
    );
    final tTVSeasonDetailModel = TVSeasonDetailModel(
      airDate: 'airDate',
      episodes: [tTVEpisodeModel],
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    );
    final int tId = 1;
    final int tSeasonNumber = 1;

    test('should return SeasonDetailTV when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber)).thenAnswer((_) async => tTVSeasonDetailModel);
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => tTVSeasonDetail);
      expect(resultList, equals(tTVSeasonDetail));
      expect(result, equals(Right(tTVSeasonDetailModel.toEntity())));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber)).thenThrow(ServerException());
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeasonDetailTV(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetailTV(tId, tSeasonNumber));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable)).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable)).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
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

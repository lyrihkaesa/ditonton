import 'dart:convert';
import 'dart:io';

import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=857427d1cb0ec0601f6d4968bef80b26';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Airing Today TVs', () {
    final tTVList = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/airing_today.json'))).tvList;

    test('should return list of TVs Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/airing_today.json'), 200));
      // act
      final result = await dataSource.getAiringTodayTVs();
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getAiringTodayTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get On The Air TVs', () {
    final tTVList = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/on_the_air.json'))).tvList;

    test('should return list of TVs Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTVs();
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVs', () {
    final tTVList = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/popular.json'))).tvList;

    test('should return list of TVs when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTVs();
      // assert
      expect(result, tTVList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TVs', () {
    final tTVList = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/top_rated.json'))).tvList;

    test('should return list of tvs when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVs();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV Detail', () {
    final tId = 1;
    final tTVDetail = TVDetailResponse.fromJson(json.decode(readJson('dummy_data/tv/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV Recommendations', () {
    final tTVList = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/tv_recommendations.json'))).tvList;
    final tId = 1;

    test('should return list of TV Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTVRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TVs', () {
    final tSearchResult = TVResponse.fromJson(json.decode(readJson('dummy_data/tv/search_mahoka_tv.json'))).tvList;
    final tQuery = 'Mahoka';

    test('should return list of TV when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/search_mahoka_tv.json'), 200));
      // act
      final result = await dataSource.searchTVs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('season detail TV', () {
    final tTVSeasonDetailModelResult =
        TVSeasonDetailModel.fromJson(json.decode(readJson('dummy_data/tv/season_detail_tv.json')));
    final int id = 115312;
    final int seasonNumber = 1;

    test('should return TVSeasonDetailModel when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/season_detail_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeasonDetailTV(id, seasonNumber);
      // assert
      expect(result, tTVSeasonDetailModelResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetailTV(id, seasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}

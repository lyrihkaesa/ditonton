import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  // arrange
  final tTVModel = TVModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2020-09-09',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTVResponse = TVResponse(tvList: <TVModel>[tTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/airing_today.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        'results': [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "first_air_date": "2020-09-09",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ]
      };

      // act
      final result = tTVResponse.toJson();

      // assert
      expect(result, expectedJsonMap);
    });
  });
}

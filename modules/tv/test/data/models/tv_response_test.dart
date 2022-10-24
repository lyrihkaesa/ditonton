import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../../../core/test/json_reader.dart';

void main() {
  const tTVResponse = TVResponse(tvList: <TVModel>[testTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/tv/airing_today.json'));
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
            "backdrop_path": "backdropPath",
            "genre_ids": [1, 2],
            "id": 1,
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "posterPath",
            "first_air_date": "firstAirDate",
            "name": "name",
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

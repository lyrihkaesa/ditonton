import 'package:ditonton/data/models/tv/tv_season_model.dart';
import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeasonModel = TVSeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTVSeasonModelJson = {
    'air_date': 'airDate',
    'episode_count': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  final tTVSeason = TVSeason(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be json form TVSeasonModel', () async {
    // assert
    final result = tTVSeasonModel.toJson();
    // act
    expect(result, tTVSeasonModelJson);
  });

  test('should be entitiy TVSeason form TVSeasonModel', () async {
    // assert
    final result = tTVSeasonModel.toEntity();
    // act
    expect(result, tTVSeason);
  });
}

import 'package:ditonton/data/models/tv/tv_season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeasonDetailModel = TVSeasonDetailModel(
    airDate: 'airDate',
    episodes: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTVSeasonDetailModelJson = {
    'air_date': 'airDate',
    'episodes': [],
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  test('should be json form TVSeasonDetailModel', () async {
    // assert
    final result = tTVSeasonDetailModel.toJson();
    // act
    expect(result, tTVSeasonDetailModelJson);
  });
}

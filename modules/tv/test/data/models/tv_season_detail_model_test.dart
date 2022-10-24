import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_season_detail_model.dart';

void main() {
  const tTVSeasonDetailModel = TVSeasonDetailModel(
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

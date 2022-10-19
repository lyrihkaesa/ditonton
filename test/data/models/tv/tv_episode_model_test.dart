import 'package:ditonton/data/models/tv/tv_episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  final tTVEpisodeModelJson = {
    'air_date': 'airDate',
    'episode_number': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'runtime': 10,
    'season_number': 1,
    'show_id': 1,
    'still_path': 'stillPath',
    'vote_average': 1.0,
    'vote_count': 1,
  };
  test('should be json form TVSeasonModel', () async {
    // assert
    final result = tTVEpisodeModel.toJson();
    // act
    expect(result, tTVEpisodeModelJson);
  });

  test('equal TV Episode model', () async {
    final tTVEpisodeModel2 = TVEpisodeModel(
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
    expect(tTVEpisodeModel == tTVEpisodeModel2, true);
  });
}

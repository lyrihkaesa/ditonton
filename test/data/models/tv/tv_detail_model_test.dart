import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  final tTVDetailResponse = TVDetailResponse(
    backdropPath: 'backdropPath',
    genres: [],
    homepage: 'homepage',
    id: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    seasons: [],
    firstAirDate: 'firstAirDate',
    episodeRuntime: [1],
    status: 'status',
    tagline: 'tagline',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    inProduction: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTVDetailResponseJson = {
    "backdrop_path": 'backdropPath',
    'genres': [],
    'homepage': 'homepage',
    'id': 1,
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'seasons': [],
    'first_air_date': 'firstAirDate',
    'episode_runtime': [1],
    'status': 'status',
    'tagline': 'tagline',
    'name': 'name',
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'in_production': false,
    'vote_average': 1.0,
    'vote_count': 1,
  };
  test('should be json form TVDetailResponse', () async {
    // assert
    final result = tTVDetailResponse.toJson();
    // act
    expect(result, tTVDetailResponseJson);
  });
}

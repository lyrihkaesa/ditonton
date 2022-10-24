import 'package:core/core.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_season_detail_model.dart';
import 'package:tv/data/models/tv_season_model.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/entities/tv_season.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';

const testTVDetailResponse = TVDetailResponse(
  backdropPath: 'backdropPath',
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  seasons: [],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1, 2],
  status: 'status',
  tagline: 'tagline',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  inProduction: false,
  voteAverage: 1.0,
  voteCount: 1,
);

final testTVDetailResponseJson = {
  "backdrop_path": 'backdropPath',
  'genres': [
    {
      'id': 1,
      'name': 'Action',
    }
  ],
  'homepage': 'homepage',
  'id': 1,
  'original_language': 'originalLanguage',
  'original_name': 'originalName',
  'overview': 'overview',
  'popularity': 1.0,
  'poster_path': 'posterPath',
  'seasons': [],
  'first_air_date': 'firstAirDate',
  'episode_runtime': [1, 2],
  'status': 'status',
  'tagline': 'tagline',
  'name': 'name',
  'number_of_episodes': 1,
  'number_of_seasons': 1,
  'in_production': false,
  'vote_average': 1.0,
  'vote_count': 1,
};

const testTVModel = TVModel(
  backdropPath: 'backdropPath',
  genreIds: [1, 2],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTV = TV(
  backdropPath: 'backdropPath',
  genreIds: const [1, 2],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTVList = [testTV];

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTVDetail = TVDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  numberOfEpisodes: 1,
  numberOfSessions: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1, 2],
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVDetailOrther = TVDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  numberOfEpisodes: 1,
  numberOfSessions: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [testTVSeason],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1],
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

const testTVEpisode = TVEpisode(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 10,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final List<TVEpisode> testTVEpisodeList = [testTVEpisode];

const testTVSeason = TVSeason(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final List<TVSeason> testTVSeasonList = [testTVSeason];

const testTVEpisodeModel = TVEpisodeModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 10,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVEpisodeModel2 = TVEpisodeModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 100,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTVEpisodeModelJson = {
  'air_date': 'airDate',
  'episode_number': 1,
  'id': 1,
  'name': 'episode name',
  'overview': 'overview',
  'runtime': 10,
  'season_number': 1,
  'show_id': 1,
  'still_path': 'stillPath',
  'vote_average': 1.0,
  'vote_count': 1,
};

const testTVSeasonModel = TVSeasonModel(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final testTVSeasonModelJson = {
  'air_date': 'airDate',
  'episode_count': 1,
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'poster_path': 'posterPath',
  'season_number': 1,
};

final testTVTableJson = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

final testTVModelList = <TVModel>[testTVModel];

const testTVSeasonDetail = TVSeasonDetail(
  airDate: 'airDate',
  episodes: [testTVEpisode],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testTVSeasonDetailModel = TVSeasonDetailModel(
  airDate: 'airDate',
  episodes: [testTVEpisodeModel],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

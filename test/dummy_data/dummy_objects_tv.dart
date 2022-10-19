import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/domain/entities/tv/tv_season.dart';

final testTV = TV(
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

final testTVList = [testTV];

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVDetail = TVDetail(
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

final testTVTable = TVTable(
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

final testTVEpisode = TVEpisode(
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

final testTVSeason = TVSeason(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final List<TVSeason> testTVSeasonList = [testTVSeason];

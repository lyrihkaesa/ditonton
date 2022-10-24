import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SSLPinning.ioClient;
  // bloc
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => SearchTVBloc(locator()));

  locator.registerFactory(() => GetNowPlayingMovieBloc(locator()));
  locator.registerFactory(() => GetPopularMoviesBloc(locator()));
  locator.registerFactory(() => GetTopRatedMoviesBloc(locator()));
  locator.registerFactory(() => GetMovieDetailBloc(locator()));
  locator.registerFactory(() => GetMovieRecommendationsBloc(locator()));
  locator.registerFactory(() => GetWatchlistMoviesBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => GetAiringTodayTVsBloc(locator()));
  locator.registerFactory(() => GetOnTheAirTVsBloc(locator()));
  locator.registerFactory(() => GetPopularTVsBloc(locator()));
  locator.registerFactory(() => GetTopRatedTVsBloc(locator()));
  locator.registerFactory(() => GetTVDetailBloc(locator()));
  locator.registerFactory(() => GetTVRecommendationsBloc(locator()));
  locator.registerFactory(() => GetWatchlistTVsBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => GetSeasonDetailTVBloc(locator()));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // use case tv
  locator.registerLazySingleton(() => GetAiringTodayTVs(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTVs(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));

  locator.registerLazySingleton(() => GetSeasonDetailTV(locator()));

  locator.registerLazySingleton(() => GetWatchListTVStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVs(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources Movie
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // data sources TV
  locator.registerLazySingleton<TVRemoteDataSource>(() => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(() => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => ioClient);
}

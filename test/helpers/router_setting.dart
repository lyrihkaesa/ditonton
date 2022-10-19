import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/airing_today_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/on_the_air_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/season_detail_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> Function(RouteSettings settings) routerSetting() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HomeMoviePage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => HomeMoviePage());
      case HomeTVPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => HomeTVPage());

      case AiringTodayTVsPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => AiringTodayTVsPage());
      case OnTheAirTVsPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => OnTheAirTVsPage());

      case PopularMoviesPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
      case PopularTVsPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => PopularTVsPage());

      case TopRatedMoviesPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case TopRatedTVsPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => TopRatedTVsPage());

      case MovieDetailPage.ROUTE_NAME:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case TVDetailPage.ROUTE_NAME:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TVDetailPage(id: id),
          settings: settings,
        );

      case SearchMoviePage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => SearchMoviePage());
      case SearchTVPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => SearchTVPage());

      case WatchlistPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => WatchlistPage());
      case WatchlistMoviesPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
      case WatchlistTVsPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => WatchlistTVsPage());

      case SeasonDetailTVPage.ROUTE_NAME:
        final season = settings.arguments as TVSeason;
        return MaterialPageRoute(
            builder: (_) => SeasonDetailTVPage(
                  season: season,
                ),
            settings: settings);

      case AboutPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('Page not found :('),
              ),
            );
          },
        );
    }
  };
}

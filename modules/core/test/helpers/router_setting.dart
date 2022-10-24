import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

Route<dynamic> Function(RouteSettings settings) routerSetting() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HOME_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeMoviePage());
      case HOME_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeTVPage());

      case AIRING_TODAY_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const AiringTodayTVsPage());
      case ON_THE_AIR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const OnTheAirTVsPage());

      case POPULAR_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
      case POPULAR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const PopularTVsPage());

      case TOP_RATED_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
      case TOP_RATED_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const TopRatedTVsPage());

      case DETAIL_MOVIE_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case DETAIL_TV_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TVDetailPage(id: id),
          settings: settings,
        );

      case SEARCH_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => const SearchMoviePage());
      case SEARCH_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const SearchTVPage());

      case WATCHLIST_ROUTE:
        return MaterialPageRoute(builder: (_) => const WatchlistPage());
      case WATCHLIST_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
      case WATCHLIST_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => const WatchlistTVsPage());

      case SEASON_DETAIL_TV_ROUTE:
        final season = settings.arguments as TVSeason;
        return MaterialPageRoute(
            builder: (_) => SeasonDetailTVPage(
                  season: season,
                ),
            settings: settings);

      case ABOUT_ROUTE:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('Page not found :('),
              ),
            );
          },
        );
    }
  };
}

import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // search
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTVBloc>()),
        // movie
        BlocProvider(create: (_) => di.locator<GetNowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<GetPopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<GetTopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<GetMovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<GetMovieRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<GetWatchlistMoviesBloc>()),
        // tv
        BlocProvider(create: (_) => di.locator<GetAiringTodayTVsBloc>()),
        BlocProvider(create: (_) => di.locator<GetOnTheAirTVsBloc>()),
        BlocProvider(create: (_) => di.locator<GetPopularTVsBloc>()),
        BlocProvider(create: (_) => di.locator<GetTopRatedTVsBloc>()),
        BlocProvider(create: (_) => di.locator<GetTVDetailBloc>()),
        BlocProvider(create: (_) => di.locator<GetTVRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<GetSeasonDetailTVBloc>()),
        BlocProvider(create: (_) => di.locator<GetWatchlistTVsBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: routerSetting(),
      ),
    );
  }
}

Route<dynamic> Function(RouteSettings settings) routerSetting() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HOME_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeMoviePage());
      case HOME_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeTVPage());

      case AIRING_TODAY_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => AiringTodayTVsPage());
      case ON_THE_AIR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => OnTheAirTVsPage());

      case POPULAR_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
      case POPULAR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => PopularTVsPage());

      case TOP_RATED_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case TOP_RATED_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedTVsPage());

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
        return CupertinoPageRoute(builder: (_) => SearchMoviePage());
      case SEARCH_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => SearchTVPage());

      case WATCHLIST_ROUTE:
        return MaterialPageRoute(builder: (_) => WatchlistPage());
      case WATCHLIST_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
      case WATCHLIST_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => WatchlistTVsPage());

      case SEASON_DETAIL_TV_ROUTE:
        final season = settings.arguments as TVSeason;
        return MaterialPageRoute(
            builder: (_) => SeasonDetailTVPage(
                  season: season,
                ),
            settings: settings);

      case ABOUT_ROUTE:
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

import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import '../../../../core/test/helpers/router_setting.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/bloc_helper_movie.dart';
import '../../../../search/test/presentation/pages/search_movie_page_test.dart';
import '../../../../tv/test/helpers/bloc_helper_tv.dart';

void main() {
  late MockGetNowPlayingMovieBloc mockGetNowPlayingMovieBloc;
  late MockGetPopularMoviesBloc mockGetPopularMoviesBloc;
  late MockGetTopRatedMoviesBloc mockGetTopRatedMoviesBloc;
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  late MockSearchMovieBloc mockSearchMovieBloc;

  late MockGetAiringTodayTVsBloc mockGetAiringTodayTVBloc;
  late MockGetOnTheAirTVsBloc mockGetOnTheAirTVsBloc;
  late MockGetPopularTVsBloc mockGetPopularTVsBloc;
  late MockGetTopRatedTVsBloc mockGetTopRatedTVsBloc;

  setUpAll(() {
    mockGetNowPlayingMovieBloc = MockGetNowPlayingMovieBloc();
    mockGetPopularMoviesBloc = MockGetPopularMoviesBloc();
    mockGetTopRatedMoviesBloc = MockGetTopRatedMoviesBloc();
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();

    mockSearchMovieBloc = MockSearchMovieBloc();

    mockGetAiringTodayTVBloc = MockGetAiringTodayTVsBloc();
    mockGetOnTheAirTVsBloc = MockGetOnTheAirTVsBloc();
    mockGetPopularTVsBloc = MockGetPopularTVsBloc();
    mockGetTopRatedTVsBloc = MockGetTopRatedTVsBloc();

    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());

    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());

    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNowPlayingMovieBloc>(create: (_) => mockGetNowPlayingMovieBloc),
        BlocProvider<GetPopularMoviesBloc>(create: (_) => mockGetPopularMoviesBloc),
        BlocProvider<GetTopRatedMoviesBloc>(create: (_) => mockGetTopRatedMoviesBloc),
        BlocProvider<GetWatchlistMoviesBloc>(create: (_) => mockGetWatchlistMoviesBloc),
        BlocProvider<SearchMovieBloc>(create: (_) => mockSearchMovieBloc),
        BlocProvider<GetAiringTodayTVsBloc>(create: (_) => mockGetAiringTodayTVBloc),
        BlocProvider<GetOnTheAirTVsBloc>(create: (_) => mockGetOnTheAirTVsBloc),
        BlocProvider<GetPopularTVsBloc>(create: (_) => mockGetPopularTVsBloc),
        BlocProvider<GetTopRatedTVsBloc>(create: (_) => mockGetTopRatedTVsBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show MovieList when Now Playing success fetch data', (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieHasData(testMovieList));
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      final movieList = find.byType(MovieList);
      final keyFailedPopularMovies = find.byKey(const Key('failed_popular_movies'));
      final keyFailedTopRatedMovies = find.byKey(const Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);

      await tester.tap(find.byType(CachedNetworkImage));
    });

    testWidgets('show MovieList when Popular Movies success fetch data', (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieHasData(testMovieList));
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      final movieList = find.byType(MovieList);
      final keyNowPlayingMovies = find.byKey(const Key('failed_now_playing_movies'));
      final keyFailedTopRatedMovies = find.byKey(const Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);
    });

    testWidgets('show MovieList when Top Rated Movies success fetch data', (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieHasData(testMovieList));

      final movieList = find.byType(MovieList);
      final keyNowPlayingMovies = find.byKey(const Key('failed_now_playing_movies'));
      final keyFailedPopularMovies = find.byKey(const Key('failed_popular_movies'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
    });

    testWidgets('show text failed when Now Playing, Popular, Top Rated Movies error fetch data',
        (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      final keyNowPlayingMovies = find.byKey(const Key('failed_now_playing_movies'));
      final keyFailedPopularMovies = find.byKey(const Key('failed_popular_movies'));
      final keyFailedTopRatedMovies = find.byKey(const Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);
    });

    testWidgets('show CircularLoading when loading fetch data', (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieLoading());
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieLoading());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieLoading());

      final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(typeCircularProgressIndicator, findsNWidgets(3));
    });
  });

  testWidgets('drawer testing', (WidgetTester tester) async {
    when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(MovieEmpty());

    when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    final ScaffoldState stateMovie = tester.firstState(find.byType(Scaffold));
    stateMovie.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.movie));
    await tester.pumpAndSettle();

    stateMovie.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.save_alt));
    await tester.pumpAndSettle();

    expect(find.byType(WatchlistPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    stateMovie.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tv));
    await tester.pumpAndSettle();

    expect(find.byType(HomeTVPage), findsOneWidget);

    final ScaffoldState stateTV = tester.firstState(find.byType(Scaffold));
    stateTV.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tv));
    await tester.pumpAndSettle();

    stateTV.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.save_alt));
    await tester.pumpAndSettle();

    expect(find.byType(WatchlistPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    stateTV.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.movie));
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsOneWidget);
  });

  testWidgets('movie search testing', (WidgetTester tester) async {
    when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());
    when(() => mockSearchMovieBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchMoviePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsOneWidget);
  });
}

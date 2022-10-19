import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/router_setting.dart';
import '../tv/home_tv_page_test.mocks.dart';
import 'home_movie_page_test.mocks.dart';
import 'search_movie_page_test.mocks.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier mockMovieNotifier;
  late MockTVListNotifier mockTVNotifier;
  late MockWatchlistMovieNotifier mockWatchlistMovieNotifier;
  late MockMovieSearchNotifier mockMovieSearchNotifier;

  setUp(() {
    mockMovieNotifier = MockMovieListNotifier();
    mockTVNotifier = MockTVListNotifier();
    mockWatchlistMovieNotifier = MockWatchlistMovieNotifier();
    mockMovieSearchNotifier = MockMovieSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieListNotifier>(
          create: (_) => mockMovieNotifier,
        ),
        ChangeNotifierProvider<TVListNotifier>(
          create: (_) => mockTVNotifier,
        ),
        ChangeNotifierProvider<WatchlistMovieNotifier>(
          create: (_) => mockWatchlistMovieNotifier,
        ),
        ChangeNotifierProvider<MovieSearchNotifier>(
          create: (_) => mockMovieSearchNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show MovieList when Now Playing success fetch data', (WidgetTester tester) async {
      when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
      when(mockMovieNotifier.nowPlayingMovies).thenReturn(testMovieList);
      when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Error);

      final movieList = find.byType(MovieList);
      final keyFailedPopularMovies = find.byKey(Key('failed_popular_movies'));
      final keyFailedTopRatedMovies = find.byKey(Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);
    });

    testWidgets('show MovieList when Popular Movies success fetch data', (WidgetTester tester) async {
      when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
      when(mockMovieNotifier.popularMovies).thenReturn(testMovieList);
      when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Error);

      final movieList = find.byType(MovieList);
      final keyNowPlayingMovies = find.byKey(Key('failed_now_playing_movies'));
      final keyFailedTopRatedMovies = find.byKey(Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);
    });

    testWidgets('show MovieList when Top Rated Movies success fetch data', (WidgetTester tester) async {
      when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);
      when(mockMovieNotifier.topRatedMovies).thenReturn(testMovieList);

      final movieList = find.byType(MovieList);
      final keyNowPlayingMovies = find.byKey(Key('failed_now_playing_movies'));
      final keyFailedPopularMovies = find.byKey(Key('failed_popular_movies'));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
    });

    testWidgets('show text failed when Now Playing, Popular, Top Rated Movies error fetch data',
        (WidgetTester tester) async {
      when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Error);
      when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Error);

      final keyNowPlayingMovies = find.byKey(Key('failed_now_playing_movies'));
      final keyFailedPopularMovies = find.byKey(Key('failed_popular_movies'));
      final keyFailedTopRatedMovies = find.byKey(Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(keyNowPlayingMovies, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);
    });

    testWidgets('show CircularLoading when loading fetch data', (WidgetTester tester) async {
      when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Loading);
      when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Loading);
      when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);

      final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(typeCircularProgressIndicator, findsNWidgets(3));
    });
  });

  testWidgets('drawer testing', (WidgetTester tester) async {
    when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Error);
    when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Error);
    when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Error);
    when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
    when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
    when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
    when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);
    when(mockWatchlistMovieNotifier.watchlistState).thenReturn(RequestState.Empty);
    when(mockWatchlistMovieNotifier.message).thenReturn('kosong');

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

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
    when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Error);
    when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Error);
    when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Error);
    when(mockMovieSearchNotifier.state).thenReturn(RequestState.Empty);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchMoviePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsOneWidget);
  });
}

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/router_setting.dart';
import '../movie/home_movie_page_test.mocks.dart';
import '../movie/watchlist_movies_page_test.mocks.dart';
import 'home_tv_page_test.mocks.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TVListNotifier])
void main() {
  late MockMovieListNotifier mockMovieNotifier;
  late MockTVListNotifier mockTVNotifier;
  late MockWatchlistMovieNotifier mockWatchlistMovieNotifier;
  late MockTVSearchNotifier mockTVSearchNotifier;

  setUp(() {
    mockMovieNotifier = MockMovieListNotifier();
    mockTVNotifier = MockTVListNotifier();
    mockWatchlistMovieNotifier = MockWatchlistMovieNotifier();
    mockTVSearchNotifier = MockTVSearchNotifier();
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
        ChangeNotifierProvider<TVSearchNotifier>(
          create: (_) => mockTVSearchNotifier,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show TVList when Airing Today success fetch data', (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Loaded);
      when(mockTVNotifier.airingTodayTVs).thenReturn(testTVList);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);

      final tvList = find.byType(TVList);
      final keyOnTheAirTVs = find.byKey(Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show TVList when On The Air success fetch data', (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Loaded);
      when(mockTVNotifier.onTheAirTVs).thenReturn(testTVList);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);

      final tvList = find.byType(TVList);
      final keyAiringTodayTVs = find.byKey(Key('failed_airing_today_tvs'));
      final keyFailedPopularTVs = find.byKey(Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyAiringTodayTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show TVList when Popular TVs success fetch data', (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Loaded);
      when(mockTVNotifier.popularTVs).thenReturn(testTVList);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);

      final tvList = find.byType(TVList);
      final keyAiringTodayTVs = find.byKey(Key('failed_airing_today_tvs'));
      final keyOnTheAirTVs = find.byKey(Key('failed_on_the_air_tvs'));
      final keyFailedTopRatedTVs = find.byKey(Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyAiringTodayTVs, findsOneWidget);
      expect(keyOnTheAirTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show TVList when Top Rated TVs success fetch data', (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Loaded);
      when(mockTVNotifier.topRatedTVs).thenReturn(testTVList);

      final tvList = find.byType(TVList);
      final keyAiringTodayTVs = find.byKey(Key('failed_airing_today_tvs'));
      final keyOnTheAirTVs = find.byKey(Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(Key('failed_popular_tvs'));

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyAiringTodayTVs, findsOneWidget);
      expect(keyOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
    });

    testWidgets('show text failed when Airing Today, On The Air, Popular, Top Rated TVs error fetch data',
        (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);

      final keyAiringTodayTVs = find.byKey(Key('failed_airing_today_tvs'));
      final keyOnTheAirTVs = find.byKey(Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(keyAiringTodayTVs, findsOneWidget);
      expect(keyOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show CircularLoading when loading fetch data', (WidgetTester tester) async {
      when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Loading);
      when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Loading);
      when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Loading);
      when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Loading);

      final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(typeCircularProgressIndicator, findsNWidgets(4));
    });
  });

  testWidgets('tv search testing', (WidgetTester tester) async {
    when(mockTVNotifier.airingTodayState).thenReturn(RequestState.Error);
    when(mockTVNotifier.onTheAirState).thenReturn(RequestState.Error);
    when(mockTVNotifier.popularTVsState).thenReturn(RequestState.Error);
    when(mockTVNotifier.topRatedTVsState).thenReturn(RequestState.Error);
    when(mockTVSearchNotifier.state).thenReturn(RequestState.Empty);

    await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchTVPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeTVPage), findsOneWidget);
  });
}

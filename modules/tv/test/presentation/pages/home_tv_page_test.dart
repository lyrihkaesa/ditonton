import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_tv_page.dart';

import '../../../../core/test/helpers/router_setting.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/bloc_helper_tv.dart';
import '../../../../search/test/presentation/pages/search_tv_page_test.dart';
import '../../../../movie/test/helpers/bloc_helper_movie.dart';

void main() {
  late MockGetAiringTodayTVsBloc mockGetAiringTodayTVBloc;
  late MockGetOnTheAirTVsBloc mockGetOnTheAirTVsBloc;
  late MockGetPopularTVsBloc mockGetPopularTVsBloc;
  late MockGetTopRatedTVsBloc mockGetTopRatedTVsBloc;
  late MockGetWatchlistTVsBloc mockGetWatchlistTVsBloc;
  late MockSearchTVBloc mockSearchTVBloc;

  late MockGetNowPlayingMovieBloc mockGetNowPlayingMovieBloc;
  late MockGetPopularMoviesBloc mockGetPopularMoviesBloc;
  late MockGetTopRatedMoviesBloc mockGetTopRatedMoviesBloc;
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetAiringTodayTVBloc = MockGetAiringTodayTVsBloc();
    mockGetOnTheAirTVsBloc = MockGetOnTheAirTVsBloc();
    mockGetPopularTVsBloc = MockGetPopularTVsBloc();
    mockGetTopRatedTVsBloc = MockGetTopRatedTVsBloc();
    mockGetWatchlistTVsBloc = MockGetWatchlistTVsBloc();
    mockSearchTVBloc = MockSearchTVBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());

    mockGetNowPlayingMovieBloc = MockGetNowPlayingMovieBloc();
    mockGetPopularMoviesBloc = MockGetPopularMoviesBloc();
    mockGetTopRatedMoviesBloc = MockGetTopRatedMoviesBloc();
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();

    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNowPlayingMovieBloc>(create: (_) => mockGetNowPlayingMovieBloc),
        BlocProvider<GetPopularMoviesBloc>(create: (_) => mockGetPopularMoviesBloc),
        BlocProvider<GetTopRatedMoviesBloc>(create: (_) => mockGetTopRatedMoviesBloc),
        BlocProvider<GetWatchlistMoviesBloc>(create: (_) => mockGetWatchlistMoviesBloc),
        BlocProvider<GetAiringTodayTVsBloc>(create: (_) => mockGetAiringTodayTVBloc),
        BlocProvider<GetOnTheAirTVsBloc>(create: (_) => mockGetOnTheAirTVsBloc),
        BlocProvider<GetPopularTVsBloc>(create: (_) => mockGetPopularTVsBloc),
        BlocProvider<GetTopRatedTVsBloc>(create: (_) => mockGetTopRatedTVsBloc),
        BlocProvider<GetWatchlistTVsBloc>(create: (_) => mockGetWatchlistTVsBloc),
        BlocProvider<SearchTVBloc>(create: (_) => mockSearchTVBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show TVList when Airing Today success fetch data', (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVHasData(testTVList));
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());

      final tvList = find.byType(TVList);
      final keyFailedOnTheAirTVs = find.byKey(const Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(const Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(const Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyFailedOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);

      await tester.tap(find.byType(CachedNetworkImage));
    });

    testWidgets('show TVList when On The Air success fetch data', (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVHasData(testTVList));
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());

      final tvList = find.byType(TVList);
      final keyFailedAiringTodayTVs = find.byKey(const Key('failed_airing_today_tvs'));
      final keyFailedPopularTVs = find.byKey(const Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(const Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(tvList, findsOneWidget);
      expect(keyFailedAiringTodayTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show TVList when Popular TVs success fetch data', (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVHasData(testTVList));
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());

      final tvList = find.byType(TVList);
      final keyFailedAiringTodayTVs = find.byKey(const Key('failed_airing_today_tvs'));
      final keyFailedOnTheAirTVs = find.byKey(const Key('failed_on_the_air_tvs'));
      final keyFailedTopRatedTVs = find.byKey(const Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(keyFailedAiringTodayTVs, findsOneWidget);
      expect(keyFailedOnTheAirTVs, findsOneWidget);
      expect(tvList, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show TVList when Top Rated TVs success fetch data', (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVHasData(testTVList));

      final tvList = find.byType(TVList);
      final keyFailedAiringTodayTVs = find.byKey(const Key('failed_airing_today_tvs'));
      final keyFailedOnTheAirTVs = find.byKey(const Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(const Key('failed_popular_tvs'));

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(keyFailedAiringTodayTVs, findsOneWidget);
      expect(keyFailedOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(tvList, findsOneWidget);
    });

    testWidgets('show text failed when Airing Today, Popular, Top Rated TVs error fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());

      final keyFailedAiringTodayTVs = find.byKey(const Key('failed_airing_today_tvs'));
      final keyFailedOnTheAirTVs = find.byKey(const Key('failed_on_the_air_tvs'));
      final keyFailedPopularTVs = find.byKey(const Key('failed_popular_tvs'));
      final keyFailedTopRatedTVs = find.byKey(const Key('failed_top_rated_tvs'));

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(keyFailedAiringTodayTVs, findsOneWidget);
      expect(keyFailedOnTheAirTVs, findsOneWidget);
      expect(keyFailedPopularTVs, findsOneWidget);
      expect(keyFailedTopRatedTVs, findsOneWidget);
    });

    testWidgets('show CircularLoading when loading fetch data', (WidgetTester tester) async {
      when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVLoading());
      when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVLoading());
      when(() => mockGetPopularTVsBloc.state).thenReturn(TVLoading());
      when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVLoading());

      final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

      expect(typeCircularProgressIndicator, findsNWidgets(4));
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
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(TVEmpty());

    await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

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

    stateTV.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.movie));
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsOneWidget);
  });

  testWidgets('tv search testing', (WidgetTester tester) async {
    when(() => mockGetAiringTodayTVBloc.state).thenReturn(TVEmpty());
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetPopularTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockSearchTVBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_makeTestableWidget(const HomeTVPage()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchTVPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeTVPage), findsOneWidget);
  });
}

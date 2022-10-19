import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import 'movie/watchlist_movies_page_test.mocks.dart';
import 'tv/watchlist_tvs_page_test.mocks.dart';

void main() {
  late MockWatchlistTVNotifier mockTVNotifier;
  late MockWatchlistMovieNotifier mockMovieNotifier;

  setUp(() {
    mockTVNotifier = MockWatchlistTVNotifier();
    mockMovieNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTVNotifier>.value(
      value: mockTVNotifier,
      child: ChangeNotifierProvider<WatchlistMovieNotifier>.value(
        value: mockMovieNotifier,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets('show loaded', (WidgetTester tester) async {
    when(mockTVNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockTVNotifier.watchlistTVs).thenReturn(testTVList);
    when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.watchlistMovies).thenReturn(testMovieList);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(find.byType(WatchlistMoviesPage), findsOneWidget);
  });
}

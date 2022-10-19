import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show MovieCard List when Watchlist success loaded', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockNotifier.watchlistMovies).thenReturn(testMovieList);

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error');

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.text('Error'), findsOneWidget);
  });
}
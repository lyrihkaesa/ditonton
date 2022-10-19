import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tvs_page_test.mocks.dart';

@GenerateMocks([WatchlistTVNotifier])
void main() {
  late MockWatchlistTVNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTVNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTVNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show TVCard List when Watchlist success loaded', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockNotifier.watchlistTVs).thenReturn(testTVList);

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistTVsPage())));

    expect(find.byType(TVCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistTVsPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error', (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error');

    await tester.pumpWidget(_makeTestableWidget(Material(child: WatchlistTVsPage())));

    expect(find.text('Error'), findsOneWidget);
  });
}

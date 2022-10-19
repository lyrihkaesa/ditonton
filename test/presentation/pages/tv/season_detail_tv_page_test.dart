import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/presentation/pages/tv/season_detail_tv_page.dart';
import 'package:ditonton/presentation/provider/tv/season_detail_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'season_detail_tv_page_test.mocks.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TVSeasonDetailNotifier])
void main() {
  late MockTVSeasonDetailNotifier mockTVSeasonDetailNotifier;
  late MockTVDetailNotifier mockTVDetailNotifier;

  setUp(() {
    mockTVSeasonDetailNotifier = MockTVSeasonDetailNotifier();
    mockTVDetailNotifier = MockTVDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVDetailNotifier>.value(
      value: mockTVDetailNotifier,
      child: ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
        value: mockTVSeasonDetailNotifier,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  final tTVSeasonDetail = TVSeasonDetail(
    airDate: 'airDate',
    episodes: [testTVEpisode],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  testWidgets('should be show TVSeasonDetailContent when TVSeasonDetail success', (WidgetTester tester) async {
    when(mockTVDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tv).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeasonDetailNotifier.tvSeasonDetailState).thenReturn(RequestState.Loaded);
    when(mockTVSeasonDetailNotifier.tvSeasonDetail).thenReturn(tTVSeasonDetail);

    await tester.pumpWidget(_makeTestableWidget(SeasonDetailTVPage(season: testTVSeason)));

    expect(find.byType(TVSeasonDetailContent), findsOneWidget);
  });

  testWidgets('should be show CircularLoading when TVSeasonDetail loading', (WidgetTester tester) async {
    when(mockTVDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tv).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeasonDetailNotifier.tvSeasonDetailState).thenReturn(RequestState.Loading);

    final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SeasonDetailTVPage(season: testTVSeason)));

    expect(typeCircularProgressIndicator, findsOneWidget);
  });

  testWidgets('should be show error message when TVSeasonDetail error', (WidgetTester tester) async {
    when(mockTVDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tv).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeasonDetailNotifier.tvSeasonDetailState).thenReturn(RequestState.Error);
    when(mockTVSeasonDetailNotifier.message).thenReturn("Error message");

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SeasonDetailTVPage(season: testTVSeason)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Navigate pop', (WidgetTester tester) async {
    when(mockTVDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tv).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeasonDetailNotifier.tvSeasonDetailState).thenReturn(RequestState.Loaded);
    when(mockTVSeasonDetailNotifier.tvSeasonDetail).thenReturn(tTVSeasonDetail);

    await tester.pumpWidget(_makeTestableWidget(Material(child: TVSeasonDetailContent(tTVSeasonDetail))));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
  });
}

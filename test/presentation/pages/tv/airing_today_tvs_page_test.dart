import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/airing_today_tvs_page.dart';
import 'package:ditonton/presentation/provider/tv/airing_today_tvs_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'airing_today_tvs_page_test.mocks.dart';

@GenerateMocks([AiringTodayTVsNotifier])
void main() {
  late MockAiringTodayTVsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockAiringTodayTVsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<AiringTodayTVsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTVsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvs).thenReturn(<TV>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTVsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TVCard when data is loaded', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvs).thenReturn(<TV>[testTV]);

    final tvCardFinder = find.byType(TVCard);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTVsPage()));

    expect(tvCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTVsPage()));

    expect(textFinder, findsOneWidget);
  });
}

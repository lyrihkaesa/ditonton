import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TVSearchNotifier])
void main() {
  group('search tv page', () {
    late MockTVSearchNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockTVSearchNotifier();
    });

    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<TVSearchNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    final tTV = TV(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3, 4],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<TV> tListTV = [tTV];

    testWidgets('should be return List TVs when success', (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.searchResult).thenReturn(tListTV);

      await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));
      await tester.enterText(find.byType(TextField), 'mahoka');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('name'), findsWidgets);
    });
    testWidgets('should be return progress loading when loading', (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);

      await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

      expect(find.byKey(Key('error_search')), findsWidgets);
    });
  });
}

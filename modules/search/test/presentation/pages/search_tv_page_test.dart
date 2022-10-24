import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_tv_page.dart';

class MockSearchTVBloc extends MockBloc<SearchEvent, SearchState> implements SearchTVBloc {}

class SearchStateFake extends Fake implements SearchState {}

class SearchEventFake extends Fake implements SearchEvent {}

void main() {
  group('search tv page', () {
    late MockSearchTVBloc mockSearchTVBloc;

    setUpAll(() {
      mockSearchTVBloc = MockSearchTVBloc();
      registerFallbackValue(SearchStateFake());
      registerFallbackValue(SearchEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchTVBloc>.value(
        value: mockSearchTVBloc,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchTVBloc.close();
    });

    final tTV = TV(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
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
      when(() => mockSearchTVBloc.state).thenReturn(SearchTVHasData(tListTV));
      await tester.pumpWidget(_makeTestableWidget(const SearchTVPage()));
      await tester.enterText(find.byType(TextField), 'mahoka');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('name'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading', (tester) async {
      when(() => mockSearchTVBloc.state).thenReturn(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(const SearchTVPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(() => mockSearchTVBloc.state).thenReturn(const SearchError('Error message'));

      await tester.pumpWidget(_makeTestableWidget(const SearchTVPage()));

      expect(find.byKey(const Key('error_search')), findsWidgets);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_movie_page.dart';

class MockSearchMovieBloc extends MockBloc<SearchEvent, SearchState> implements SearchMovieBloc {}

class SearchStateFake extends Fake implements SearchState {}

class SearchEventFake extends Fake implements SearchEvent {}

void main() {
  group('search movie page', () {
    late MockSearchMovieBloc mockSearchMovieBloc;

    setUpAll(() {
      mockSearchMovieBloc = MockSearchMovieBloc();
      registerFallbackValue(SearchStateFake());
      registerFallbackValue(SearchEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchMovieBloc>.value(
        value: mockSearchMovieBloc,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchMovieBloc.close();
    });

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<Movie> tListMovie = [tMovie];

    testWidgets('should be return List Movies when success', (tester) async {
      when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieHasData(tListMovie));
      await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));
      await tester.enterText(find.byType(TextField), 'mahoka');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('title'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading', (tester) async {
      when(() => mockSearchMovieBloc.state).thenReturn(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(() => mockSearchMovieBloc.state).thenReturn(const SearchError('Error message'));

      await tester.pumpWidget(_makeTestableWidget(const SearchMoviePage()));

      expect(find.byKey(const Key('error_search')), findsWidgets);
    });
  });
}

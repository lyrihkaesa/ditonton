import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_movie_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  group('search movie page', () {
    late MockMovieSearchNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockMovieSearchNotifier();
    });

    Widget _makeTestableWidget(Widget body) {
      return ChangeNotifierProvider<MovieSearchNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3, 4],
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
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.searchResult).thenReturn(tListMovie);
      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));
      await tester.enterText(find.byType(TextField), 'mahoka');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('title'), findsWidgets);
    });
    testWidgets('should be return progress loading when loading', (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));

      expect(find.byKey(Key('error_search')), findsWidgets);
    });
  });
}

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../pages/movie/movie_detail_page_test.mocks.dart';

void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Material(child: body),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

  testWidgets('show movie card list', (tester) async {
    final titleMovie = find.byKey(Key('movie-title'));
    final overviewMovie = find.byKey(Key('movie-overview'));
    final posterPathMovie = find.byKey(Key('movie-poster-path'));

    await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

    expect(titleMovie, findsOneWidget);
    expect(overviewMovie, findsOneWidget);
    expect(posterPathMovie, findsOneWidget);
  });

  testWidgets('should be navigation to movie detail page when tap inkwell',
      (tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error data tidak ditemukan');

    final typeMovieDetailPage = find.byType(MovieDetailPage);

    await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(typeMovieDetailPage, findsOneWidget);
  });
}

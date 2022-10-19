import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie/home_movie_page_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockMovieListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieListNotifier();
  });

  group('about page', () {
    Widget _makeTestableWidget(Widget body) {
      return MaterialApp(
        home: body,
      );
    }

    Widget _makeTestableWidgetPrimay(Widget body) {
      return ChangeNotifierProvider<MovieListNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          home: body,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomeMoviePage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());
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

    testWidgets('show about image', (tester) async {
      final aboutImg = find.byKey(Key('about_img'));

      await tester.pumpWidget(_makeTestableWidget(AboutPage()));

      expect(aboutImg, findsOneWidget);
    });

    testWidgets('show about description', (tester) async {
      final aboutDesc = find.byKey(Key('about_desc'));

      await tester.pumpWidget(_makeTestableWidget(AboutPage()));

      expect(aboutDesc, findsOneWidget);
    });

    testWidgets('show button back', (tester) async {
      final iconArrowBack = find.byIcon(Icons.arrow_back);
      final iconButton = find.byType(IconButton);

      await tester.pumpWidget(_makeTestableWidget(AboutPage()));

      expect(iconArrowBack, findsOneWidget);
      expect(iconButton, findsOneWidget);
    });

    testWidgets('navigation pop when button arrow back onPressed',
        (tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.Error);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Error);
      final keyDrawer = find.byKey(Key('drawer-movie'));
      final keyListTile = find.byKey(Key('listtile-about-key'));
      final typeAboutPage = find.byType(AboutPage);
      final keyBack = find.byKey(Key('icon_arrow_back_button'));
      final typeHomeMoviePage = find.byType(HomeMoviePage);

      await tester.pumpWidget(_makeTestableWidgetPrimay(HomeMoviePage()));

      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pump();
      expect(keyDrawer, findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(keyListTile);
      await tester.pumpAndSettle();
      expect(typeAboutPage, findsOneWidget);
      await tester.tap(keyBack);
      await tester.pumpAndSettle();
      expect(typeHomeMoviePage, findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/bloc_helper_movie.dart';
import '../../../../core/test/helpers/router_setting.dart';

void main() {
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetWatchlistMoviesBloc>(create: (_) => mockGetWatchlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('should be show MovieCard List when Watchlist success loaded', (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(MovieHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading', (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(MovieLoading());

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error', (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieError('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}

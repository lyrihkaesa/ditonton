import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/widgets/recommendation_movie_list.dart';

import '../../dummy_data/dummy_objects_movie.dart';
import '../../../../core/test/helpers/router_setting.dart';
import '../../helpers/bloc_helper_movie.dart';

void main() {
  late MockGetMovieDetailBloc mockGetMovieDetailBloc;
  late MockGetMovieRecommendationsBloc mockGetMovieRecommendationsBloc;
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetMovieDetailBloc = MockGetMovieDetailBloc();
    mockGetMovieRecommendationsBloc = MockGetMovieRecommendationsBloc();
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMovieDetailBloc>(create: (_) => mockGetMovieDetailBloc),
        BlocProvider<GetMovieRecommendationsBloc>(create: (_) => mockGetMovieRecommendationsBloc),
        BlocProvider<GetWatchlistMoviesBloc>(create: (_) => mockGetWatchlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetailOrther));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieHasData(testMovieList));
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(true));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(GetWatchlistMoviesBloc.watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when removed from watchlist', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(GetWatchlistMoviesBloc.watchlistRemoveSuccessMessage), findsOneWidget);
  });

  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('loading progress bar', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(MovieLoading());
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieLoading());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('recomendation movie loading progress bar', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieLoading());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(circularProgressIndicator, findsWidgets);
  });

  testWidgets('recomendation movie error', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(const MovieError('recommendation error'));
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('recommendation error'), findsOneWidget);
  });

  testWidgets('recomendation movie empty', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byKey(const Key('empty_recommendation')), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
  });

  testWidgets('should be navigate to MovieDetailPage when Image tap', (tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieHasData(testMovieList));
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const MovieWatchlistStatus(false));
    await tester
        .pumpWidget(_makeTestableWidget(Material(child: RecommendationMovieList(recommendations: testMovieList))));
    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
  });
}

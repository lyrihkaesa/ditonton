import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/widgets/recommendation_tv_list.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../../../core/test/helpers/router_setting.dart';
import '../../helpers/bloc_helper_tv.dart';

void main() {
  late MockGetTVDetailBloc mockGetTVDetailBloc;
  late MockGetTVRecommendationsBloc mockGetTVRecommendationsBloc;
  late MockGetWatchlistTVsBloc mockGetWatchlistTVsBloc;

  setUpAll(() {
    mockGetTVDetailBloc = MockGetTVDetailBloc();
    mockGetTVRecommendationsBloc = MockGetTVRecommendationsBloc();
    mockGetWatchlistTVsBloc = MockGetWatchlistTVsBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTVDetailBloc>(create: (_) => mockGetTVDetailBloc),
        BlocProvider<GetTVRecommendationsBloc>(create: (_) => mockGetTVRecommendationsBloc),
        BlocProvider<GetWatchlistTVsBloc>(create: (_) => mockGetWatchlistTVsBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when tv not added to watchlist', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVHasData(testTVList));
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when tv is added to wathclist', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(true));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(GetWatchlistTVsBloc.watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when removed from watchlist', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(GetWatchlistTVsBloc.watchlistRemoveSuccessMessage), findsOneWidget);
  });

  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('loading progress bar', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(TVLoading());
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVLoading());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('recomendation tv loading progress bar', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVLoading());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(circularProgressIndicator, findsWidgets);
  });

  testWidgets('recomendation tv error', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(const TVError('recommendation error'));
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text('recommendation error'), findsOneWidget);
  });

  testWidgets('recomendation tv empty', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.byKey(const Key('empty_recommendation')), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
  });

  testWidgets('should be navigate to TVDetailPage when Image tap', (tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetail));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVHasData(testTVList));
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));
    await tester.pumpWidget(_makeTestableWidget(Material(child: RecommendationTVList(recommendations: testTVList))));
    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
  });

  testWidgets('should be text error when be error load', (tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVError('error'));
    when(() => mockGetTVRecommendationsBloc.state).thenReturn(TVEmpty());
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVWatchlistStatus(false));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text('error'), findsOneWidget);
  });
}

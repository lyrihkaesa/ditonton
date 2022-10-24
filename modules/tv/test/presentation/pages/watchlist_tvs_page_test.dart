import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tvs_page.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/bloc_helper_tv.dart';
import '../../../../core/test/helpers/router_setting.dart';

void main() {
  late MockGetWatchlistTVsBloc mockGetWatchlistTVsBloc;

  setUpAll(() {
    mockGetWatchlistTVsBloc = MockGetWatchlistTVsBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetWatchlistTVsBloc>(create: (_) => mockGetWatchlistTVsBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('should be show TVCard List when Watchlist success loaded', (WidgetTester tester) async {
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(TVHasData(testTVList));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistTVsPage())));

    expect(find.byType(TVCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading', (WidgetTester tester) async {
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(TVLoading());

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistTVsPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error', (WidgetTester tester) async {
    when(() => mockGetWatchlistTVsBloc.state).thenReturn(const TVError('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: WatchlistTVsPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}

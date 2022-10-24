import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_tvs_page.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/bloc_helper_tv.dart';
import '../../../../core/test/helpers/router_setting.dart';

void main() {
  late MockGetOnTheAirTVsBloc mockGetOnTheAirTVsBloc;

  setUpAll(() {
    mockGetOnTheAirTVsBloc = MockGetOnTheAirTVsBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetOnTheAirTVsBloc>(create: (_) => mockGetOnTheAirTVsBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTVsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVHasData(testTVList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTVsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TVCard when data is loaded', (WidgetTester tester) async {
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVHasData(testTVList));

    final tvCardFinder = find.byType(TVCard);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTVsPage()));

    expect(tvCardFinder, findsOneWidget);

    await tester.tap(find.byType(TVCard));
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(const TVError('error'));

    final textFinder = find.text('error');

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTVsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty', (WidgetTester tester) async {
    when(() => mockGetOnTheAirTVsBloc.state).thenReturn(TVEmpty());

    final textFinder = find.byKey(const Key('empty'));

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTVsPage()));

    expect(textFinder, findsOneWidget);
  });
}

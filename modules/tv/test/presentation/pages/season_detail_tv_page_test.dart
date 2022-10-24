import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/season_detail_tv_page.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../../../core/test/helpers/router_setting.dart';
import '../../helpers/bloc_helper_tv.dart';

void main() {
  late MockGetTVDetailBloc mockGetTVDetailBloc;
  late MockGetSeasonDetailTVBloc mockGetSeasonDetailTVBloc;

  setUpAll(() {
    mockGetTVDetailBloc = MockGetTVDetailBloc();
    mockGetSeasonDetailTVBloc = MockGetSeasonDetailTVBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTVDetailBloc>(create: (_) => mockGetTVDetailBloc),
        BlocProvider<GetSeasonDetailTVBloc>(create: (_) => mockGetSeasonDetailTVBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('should be show TVSeasonDetailContent when TVSeasonDetail success', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(const TVSeasonDetailHasData(testTVSeasonDetail));

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailTVPage(season: testTVSeason)));

    expect(find.byType(TVSeasonDetailContent), findsOneWidget);
  });

  testWidgets('should be show CircularLoading when TVSeasonDetail loading', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(TVLoading());

    final typeCircularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailTVPage(season: testTVSeason)));

    expect(typeCircularProgressIndicator, findsOneWidget);
  });

  testWidgets('should be show error message when TVSeasonDetail error', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(const TVError('error'));

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailTVPage(season: testTVSeason)));

    expect(find.text('error'), findsOneWidget);
  });

  testWidgets('should be show Empty Data when TVSeasonDetail empty', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(TVEmpty());

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailTVPage(season: testTVSeason)));

    expect(find.text('Empty Data'), findsOneWidget);
  });

  testWidgets('Navigate pop', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(const TVDetailHasData(testTVDetailOrther));
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(const TVSeasonDetailHasData(testTVSeasonDetail));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: TVSeasonDetailContent(testTVSeasonDetail))));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
  });

  testWidgets('should be unknown title when tvdetail empty', (WidgetTester tester) async {
    when(() => mockGetTVDetailBloc.state).thenReturn(TVEmpty());
    when(() => mockGetSeasonDetailTVBloc.state).thenReturn(const TVSeasonDetailHasData(testTVSeasonDetail));

    await tester.pumpWidget(_makeTestableWidget(const Material(child: TVSeasonDetailContent(testTVSeasonDetail))));

    expect(find.text('Unknown Title'), findsOneWidget);
  });
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/season_list.dart';

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

  testWidgets('should be navigate to SeasonDetailPage when Image tap', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(Material(child: SeasonList(seasons: testTVSeasonList))));

    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
  });
}

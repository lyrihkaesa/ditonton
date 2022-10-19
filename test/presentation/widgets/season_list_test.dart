import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/season_detail_tv_page.dart';
import 'package:ditonton/presentation/provider/tv/season_detail_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/season_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/router_setting.dart';
import '../pages/tv/season_detail_tv_page_test.mocks.dart';
import '../pages/tv/tv_detail_page_test.mocks.dart';

void main() {
  late MockTVSeasonDetailNotifier mockNotifier;
  late MockTVDetailNotifier mockTVDetailNotifier;

  setUp(() {
    mockNotifier = MockTVSeasonDetailNotifier();
    mockTVDetailNotifier = MockTVDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVDetailNotifier>.value(
      value: mockTVDetailNotifier,
      child: ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          home: body,
          onGenerateRoute: routerSetting(),
        ),
      ),
    );
  }

  testWidgets('should be navigate to SeasonDetailPage when Image tap', (tester) async {
    when(mockTVDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVDetailNotifier.tv).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.message).thenReturn('Error');
    when(mockNotifier.tvSeasonDetailState).thenReturn(RequestState.Empty);
    when(mockNotifier.message).thenReturn('Error');
    await tester.pumpWidget(_makeTestableWidget(Material(child: SeasonList(seasons: testTVSeasonList))));

    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
    await tester.pumpAndSettle();

    expect(find.byType(SeasonDetailTVPage), findsOneWidget);
  });
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/recommendation_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/router_setting.dart';
import '../pages/tv/tv_detail_page_test.mocks.dart';

void main() {
  late MockTVDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTVDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('should be navigate to TVDetailPage when Image tap', (tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Empty);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.message).thenReturn('Error');
    await tester.pumpWidget(_makeTestableWidget(Material(child: RecommendationTVList(recommendations: testTVList))));

    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
    await tester.pumpAndSettle();

    expect(find.byType(TVDetailPage), findsOneWidget);
  });
}

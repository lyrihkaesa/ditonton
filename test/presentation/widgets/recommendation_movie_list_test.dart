import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/recommendation_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/router_setting.dart';
import '../pages/movie/movie_detail_page_test.mocks.dart';

void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('should be navigate to MovieDetailPage when Image tap', (tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Empty);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.message).thenReturn('Error');
    await tester
        .pumpWidget(_makeTestableWidget(Material(child: RecommendationMovieList(recommendations: testMovieList))));

    final typeCachedNetworkImage = find.byType(CachedNetworkImage);

    expect(typeCachedNetworkImage, findsOneWidget);

    await tester.tap(typeCachedNetworkImage);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
  });
}

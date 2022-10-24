void main() {}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movie/presentation/pages/movie_detail_page.dart';
// import 'package:movie/presentation/provider/movie_detail_notifier.dart';
// import 'package:movie/presentation/widgets/recommendation_movie_list.dart';
// import 'package:provider/provider.dart';

// import '../../../../core/test/helpers/router_setting.dart';
// import '../../dummy_data/dummy_objects_movie.dart';
// import '../pages/movie_detail_page_test.mocks.dart';

// void main() {
//   late MockMovieDetailNotifier mockNotifier;

//   setUp(() {
//     mockNotifier = MockMovieDetailNotifier();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return ChangeNotifierProvider<MovieDetailNotifier>.value(
//       value: mockNotifier,
//       child: MaterialApp(
//         home: body,
//         onGenerateRoute: routerSetting(),
//       ),
//     );
//   }

//   testWidgets('should be navigate to MovieDetailPage when Image tap', (tester) async {
//     when(mockNotifier.movieState).thenReturn(RequestState.Empty);
//     when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
//     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
//     when(mockNotifier.message).thenReturn('Error');
//     await tester
//         .pumpWidget(_makeTestableWidget(Material(child: RecommendationMovieList(recommendations: testMovieList))));

//     final typeCachedNetworkImage = find.byType(CachedNetworkImage);

//     expect(typeCachedNetworkImage, findsOneWidget);

//     await tester.tap(typeCachedNetworkImage);
//     await tester.pumpAndSettle();

//     expect(find.byType(MovieDetailPage), findsOneWidget);
//   });
// }

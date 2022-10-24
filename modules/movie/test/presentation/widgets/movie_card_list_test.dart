void main() {}
// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movie/presentation/pages/movie_detail_page.dart';
// import 'package:movie/presentation/provider/movie_detail_notifier.dart';
// import 'package:movie/presentation/widgets/movie_card_list.dart';
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
//       child: MaterialApp(home: Material(child: body), onGenerateRoute: routerSetting()),
//     );
//   }

//   testWidgets('show movie card list', (tester) async {
//     final titleMovie = find.text('Spider-Man');

//     await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));

//     expect(titleMovie, findsOneWidget);
//   });

//   testWidgets('should be navigation to movie detail page when tap inkwell', (tester) async {
//     when(mockNotifier.movieState).thenReturn(RequestState.Error);
//     when(mockNotifier.message).thenReturn('Error data tidak ditemukan');

//     final typeMovieDetailPage = find.byType(MovieDetailPage);

//     await tester.pumpWidget(_makeTestableWidget(MovieCard(testMovie)));
//     await tester.tap(find.byType(InkWell));
//     await tester.pumpAndSettle();

//     expect(typeMovieDetailPage, findsOneWidget);
//   });
// }

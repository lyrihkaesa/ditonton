import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects_tv.dart';
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
        home: Material(child: body),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

  // testWidgets('show tv card list', (tester) async {
  //   final titleTV = find.byKey(Key('tv-title'));
  //   final overviewTV = find.byKey(Key('tv-overview'));
  //   final posterPathTV = find.byKey(Key('tv-poster-path'));

  //   await tester.pumpWidget(_makeTestableWidget(TVCard(testTV)));

  //   expect(titleTV, findsOneWidget);
  //   expect(overviewTV, findsOneWidget);
  //   expect(posterPathTV, findsOneWidget);
  // });

  testWidgets('should be navigation to tv detail page when tap inkwell',
      (tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error data tidak ditemukan');

    final typeTVDetailPage = find.byType(TVDetailPage);

    await tester.pumpWidget(_makeTestableWidget(TVCard(testTV)));
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(typeTVDetailPage, findsOneWidget);
  });
}

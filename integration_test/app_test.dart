import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Ditonton TV Series Search, Add & Remove Watchlist', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    // do
    // open drawer
    final ScaffoldState stateMovie = tester.firstState(find.byType(Scaffold));
    stateMovie.openDrawer();
    await tester.pumpAndSettle();

    // tap icon tv
    await tester.tap(find.byIcon(Icons.tv));
    await tester.pumpAndSettle();

    // TV Series Page
    expect(find.text('Ditonton TV Series'), findsOneWidget);

    // tap icon search
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // text input "mahoka"
    await tester.enterText(find.byType(TextField), 'mahoka');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // tap title
    await tester.tap(find.text('The Irregular at Magic High School'));
    await tester.pumpAndSettle();

    // check add icon
    expect(find.byIcon(Icons.add), findsOneWidget);

    // tap elevated button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // check snackbar with text "Added to Watchlist"
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);

    // tap icon arrow back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // tap icon arrow back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // open drawer
    final ScaffoldState stateTV = tester.firstState(find.byType(Scaffold));
    stateTV.openDrawer();
    await tester.pumpAndSettle();

    // tap watchlist icon
    await tester.tap(find.byIcon(Icons.save_alt));
    await tester.pumpAndSettle();

    // tap top nav TV Series
    await tester.tap(find.text('TV Series'));
    await tester.pumpAndSettle();

    // tap title
    await tester.tap(find.text('The Irregular at Magic High School'));
    await tester.pumpAndSettle();

    // check icon check
    expect(find.byIcon(Icons.check), findsOneWidget);

    // tap elevated button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // check snackbar with text "Removed from Watchlist"
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });
}

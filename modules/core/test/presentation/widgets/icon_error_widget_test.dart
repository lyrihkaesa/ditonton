import 'package:core/presentation/widgets/icon_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('icon error widget', (tester) async {
    final iconError = find.byIcon(Icons.error);

    await tester.pumpWidget(const MaterialApp(home: IconErrorWidget()));

    expect(iconError, findsOneWidget);
  });
}

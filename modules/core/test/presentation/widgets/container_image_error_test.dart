import 'package:core/presentation/widgets/container_image_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('container image error home show icon error...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ContainerImageErrorHome(),
    ));

    expect(find.byIcon(Icons.error), findsOneWidget);
  });

  testWidgets('container image error show icon error...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ContainerImageError(),
    ));

    expect(find.byIcon(Icons.error), findsOneWidget);
  });
}

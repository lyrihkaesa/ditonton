import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  testWidgets('show episode card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EpisodeCard(episode: testTVEpisode),
    ));

    expect(find.text('episode name'), findsOneWidget);
  });
}

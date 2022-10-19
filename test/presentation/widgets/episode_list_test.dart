import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:ditonton/presentation/widgets/episode_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  testWidgets('show episode list', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EpisodeList(episodes: testTVEpisodeList),
    ));

    expect(find.byType(EpisodeCard), findsOneWidget);
  });
}

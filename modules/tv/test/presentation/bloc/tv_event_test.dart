import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

import '../../dummy_data/dummy_objects_tv.dart';

void main() {
  testWidgets('movie event', (tester) async {
    expect(const OnDetailTV(1) != const OnDetailTV(2), true);
    expect(const OnTVRecommendations(1) != const OnTVRecommendations(2), true);
    expect(const OnWatchlistTVStatus(1) != const OnWatchlistTVStatus(2), true);
    expect(const OnSaveWatchlistTV(testTVDetail) != const OnSaveWatchlistTV(testTVDetailOrther), true);
    expect(const OnRemoveWatchlistTV(testTVDetail) != const OnRemoveWatchlistTV(testTVDetailOrther), true);
    expect(const OnSeasonDetailTV(1, 1) != const OnSeasonDetailTV(2, 2), true);
  });
}

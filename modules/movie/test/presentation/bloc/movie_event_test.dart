import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

import '../../dummy_data/dummy_objects_movie.dart';

void main() {
  testWidgets('movie event', (tester) async {
    expect(const OnDetailMovie(1) != const OnDetailMovie(2), true);
    expect(const OnMovieRecommendations(1) != const OnMovieRecommendations(2), true);
    expect(const OnWatchlistMovieStatus(1) != const OnWatchlistMovieStatus(2), true);
    expect(const OnSaveWatchlistMovie(testMovieDetail) != const OnSaveWatchlistMovie(testMovieDetailOrther), true);
    expect(const OnRemoveWatchlistMovie(testMovieDetail) != const OnRemoveWatchlistMovie(testMovieDetailOrther), true);
  });
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_season_detail_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetailTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetSeasonDetailTV(mockTVRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tTVEpisode = TVEpisode(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    runtime: 10,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTVSeasonDetail = TVSeasonDetail(
    airDate: 'airDate',
    episodes: [tTVEpisode],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should get TVSeasonDetail from the repository', () async {
    // arrange
    when(mockTVRepository.getSeasonDetailTV(tId, tSeasonNumber)).thenAnswer((_) async => Right(tTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(tTVSeasonDetail));
  });
}

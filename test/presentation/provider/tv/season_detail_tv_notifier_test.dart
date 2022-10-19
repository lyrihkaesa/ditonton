import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_season_detail_tv.dart';
import 'package:ditonton/presentation/provider/tv/season_detail_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'season_detail_tv_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeasonDetailTV,
])
void main() {
  late TVSeasonDetailNotifier provider;
  late MockGetSeasonDetailTV mockGetSeasonDetailTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonDetailTV = MockGetSeasonDetailTV();
    provider = TVSeasonDetailNotifier(getSeasonDetailTV: mockGetSeasonDetailTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
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

  void _arrangeUsecase() {
    when(mockGetSeasonDetailTV.execute(tId, tSeasonNumber)).thenAnswer((_) async => Right(tTVSeasonDetail));
  }

  group('Get Season Detail TV', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockGetSeasonDetailTV.execute(tId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv season detail when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonDetailState, RequestState.Loaded);
      expect(provider.tvSeasonDetail, tTVSeasonDetail);
      expect(listenerCallCount, 3);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeasonDetailTV.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

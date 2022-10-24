import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_airing_today_tvs.dart';
import 'package:tv/domain/usecases/get_on_the_air_tvs.dart';
import 'package:tv/domain/usecases/get_season_detail_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTVs,
  GetOnTheAirTVs,
  GetPopularTVs,
  GetTopRatedTVs,
  GetTVDetail,
  GetTVRecommendations,
  GetWatchlistTVs,
  GetWatchListTVStatus,
  SaveWatchlistTV,
  RemoveWatchlistTV,
  GetSeasonDetailTV,
])
void main() {
  late GetAiringTodayTVsBloc getAiringTodayTVsBloc;
  late GetOnTheAirTVsBloc getOnTheAirTVsBloc;
  late GetPopularTVsBloc getPopularTVsBloc;
  late GetTopRatedTVsBloc getTopRatedTVsBloc;
  late GetTVDetailBloc getTVDetailBloc;
  late GetTVRecommendationsBloc getTVRecommendationsBloc;
  late GetWatchlistTVsBloc getWatchlistTVsBloc;
  late GetSeasonDetailTVBloc getSeasonDetailTVBloc;

  late MockGetAiringTodayTVs mockGetAiringTodayTVs;
  late MockGetOnTheAirTVs mockGetOnTheAirTVs;
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchlistTVs mockGetWatchlistTVs;
  late MockGetWatchListTVStatus mockGetWatchListTVStatus;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;
  late MockGetSeasonDetailTV mockGetSeasonDetailTV;

  setUp(() {
    mockGetAiringTodayTVs = MockGetAiringTodayTVs();
    mockGetOnTheAirTVs = MockGetOnTheAirTVs();
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistTVs = MockGetWatchlistTVs();
    mockGetWatchListTVStatus = MockGetWatchListTVStatus();
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    mockGetSeasonDetailTV = MockGetSeasonDetailTV();

    getAiringTodayTVsBloc = GetAiringTodayTVsBloc(mockGetAiringTodayTVs);
    getOnTheAirTVsBloc = GetOnTheAirTVsBloc(mockGetOnTheAirTVs);
    getPopularTVsBloc = GetPopularTVsBloc(mockGetPopularTVs);
    getTopRatedTVsBloc = GetTopRatedTVsBloc(mockGetTopRatedTVs);
    getTVDetailBloc = GetTVDetailBloc(mockGetTVDetail);
    getTVRecommendationsBloc = GetTVRecommendationsBloc(mockGetTVRecommendations);
    getWatchlistTVsBloc = GetWatchlistTVsBloc(
      mockGetWatchlistTVs,
      mockGetWatchListTVStatus,
      mockSaveWatchlistTV,
      mockRemoveWatchlistTV,
    );
    getSeasonDetailTVBloc = GetSeasonDetailTVBloc(mockGetSeasonDetailTV);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tSaveMessage = GetWatchlistTVsBloc.watchlistAddSuccessMessage;
  const tRemoveMessage = GetWatchlistTVsBloc.watchlistRemoveSuccessMessage;

  group('airing today tvs', () {
    test('initial state should be loading', () {
      expect(getAiringTodayTVsBloc.state, TVLoading());
    });

    blocTest<GetAiringTodayTVsBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTVs.execute()).thenAnswer((_) async => Right(testTVList));
        return getAiringTodayTVsBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodayTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTVs.execute());
      },
    );

    blocTest<GetAiringTodayTVsBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetAiringTodayTVs.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getAiringTodayTVsBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodayTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTVs.execute());
      },
    );
  });

  group('on the air tvs', () {
    test('initial state should be loading', () {
      expect(getOnTheAirTVsBloc.state, TVLoading());
    });

    blocTest<GetOnTheAirTVsBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTVs.execute()).thenAnswer((_) async => Right(testTVList));
        return getOnTheAirTVsBloc;
      },
      act: (bloc) => bloc.add(OnOnTheAirTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTVs.execute());
      },
    );

    blocTest<GetOnTheAirTVsBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetOnTheAirTVs.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getOnTheAirTVsBloc;
      },
      act: (bloc) => bloc.add(OnOnTheAirTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTVs.execute());
      },
    );
  });

  group('popular tvs', () {
    test('initial state should be loading', () {
      expect(getPopularTVsBloc.state, TVLoading());
    });

    blocTest<GetPopularTVsBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(testTVList));
        return getPopularTVsBloc;
      },
      act: (bloc) => bloc.add(OnPopularTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVs.execute());
      },
    );
    blocTest<GetPopularTVsBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetPopularTVs.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getPopularTVsBloc;
      },
      act: (bloc) => bloc.add(OnPopularTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVs.execute());
      },
    );
  });

  group('top rated tvs', () {
    test('initial state should be loading', () {
      expect(getTopRatedTVsBloc.state, TVLoading());
    });

    blocTest<GetTopRatedTVsBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVs.execute()).thenAnswer((_) async => Right(testTVList));
        return getTopRatedTVsBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVs.execute());
      },
    );
    blocTest<GetTopRatedTVsBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTopRatedTVs.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getTopRatedTVsBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVs.execute());
      },
    );
  });

  group('tv detail', () {
    test('initial state should be loading', () {
      expect(getTVDetailBloc.state, TVLoading());
    });

    blocTest<GetTVDetailBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(tId)).thenAnswer((_) async => const Right(testTVDetail));
        return getTVDetailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailTV(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVDetailHasData(testTVDetail),
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
      },
    );
    blocTest<GetTVDetailBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTVDetail.execute(tId)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getTVDetailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailTV(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
      },
    );
  });

  group('tv recommendations', () {
    test('initial state should be loading', () {
      expect(getTVRecommendationsBloc.state, TVLoading());
    });

    blocTest<GetTVRecommendationsBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVRecommendations.execute(tId)).thenAnswer((_) async => Right(testTVList));
        return getTVRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTVRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetTVRecommendations.execute(tId));
      },
    );
    blocTest<GetTVRecommendationsBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getTVRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTVRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTVRecommendations.execute(tId));
      },
    );
  });

  group('watchlist tvs', () {
    test('initial state should be loading', () {
      expect(getWatchlistTVsBloc.state, TVLoading());
    });
    group('get watchlist tvs list', () {
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTVs.execute()).thenAnswer((_) async => Right(testTVList));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTVs()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          TVHasData(testTVList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTVs.execute());
        },
      );
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockGetWatchlistTVs.execute()).thenAnswer((_) async => const Left(DatabaseFailure('Database Failure')));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTVs()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTVs.execute());
        },
      );
    });

    group('get watchlist tvs status', () {
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchListTVStatus.execute(tId)).thenAnswer((_) async => true);
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(const OnWatchlistTVStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListTVStatus.execute(tId));
        },
      );
    });

    group('save watchlist tv', () {
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlistTV.execute(testTVDetail)).thenAnswer((_) async => const Right(tSaveMessage));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(const OnSaveWatchlistTV(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVWatchlistMessage(tSaveMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTV.execute(testTVDetail));
        },
      );
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockSaveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Database Failure')));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(const OnSaveWatchlistTV(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTV.execute(testTVDetail));
        },
      );
    });
    group('remove watchlist tv', () {
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlistTV.execute(testTVDetail)).thenAnswer((_) async => const Right(tRemoveMessage));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveWatchlistTV(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVWatchlistMessage(tRemoveMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTV.execute(testTVDetail));
        },
      );
      blocTest<GetWatchlistTVsBloc, TVState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockRemoveWatchlistTV.execute(testTVDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Database Failure')));
          return getWatchlistTVsBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveWatchlistTV(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTV.execute(testTVDetail));
        },
      );
    });
  });

  group('season tv detail', () {
    test('initial state should be loading', () {
      expect(getSeasonDetailTVBloc.state, TVLoading());
    });

    blocTest<GetSeasonDetailTVBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSeasonDetailTV.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => const Right(testTVSeasonDetail));
        return getSeasonDetailTVBloc;
      },
      act: (bloc) => bloc.add(const OnSeasonDetailTV(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVSeasonDetailHasData(testTVSeasonDetail),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetailTV.execute(tId, tSeasonNumber));
      },
    );

    blocTest<GetSeasonDetailTVBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetSeasonDetailTV.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return getSeasonDetailTVBloc;
      },
      act: (bloc) => bloc.add(const OnSeasonDetailTV(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetailTV.execute(tId, tSeasonNumber));
      },
    );
  });
}

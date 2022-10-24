import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class TVStateFake extends Fake implements TVState {}

class TVEventFake extends Fake implements TVEvent {}

class MockGetAiringTodayTVsBloc extends MockBloc<TVEvent, TVState> implements GetAiringTodayTVsBloc {}

class MockGetOnTheAirTVsBloc extends MockBloc<TVEvent, TVState> implements GetOnTheAirTVsBloc {}

class MockGetPopularTVsBloc extends MockBloc<TVEvent, TVState> implements GetPopularTVsBloc {}

class MockGetTopRatedTVsBloc extends MockBloc<TVEvent, TVState> implements GetTopRatedTVsBloc {}

class MockGetTVDetailBloc extends MockBloc<TVEvent, TVState> implements GetTVDetailBloc {}

class MockGetTVRecommendationsBloc extends MockBloc<TVEvent, TVState> implements GetTVRecommendationsBloc {}

class MockGetWatchlistTVsBloc extends MockBloc<TVEvent, TVState> implements GetWatchlistTVsBloc {}

class MockGetSeasonDetailTVBloc extends MockBloc<TVEvent, TVState> implements GetSeasonDetailTVBloc {}

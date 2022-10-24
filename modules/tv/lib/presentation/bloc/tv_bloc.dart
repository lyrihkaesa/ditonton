import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
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

part 'tv_event.dart';
part 'tv_state.dart';

class GetAiringTodayTVsBloc extends Bloc<TVEvent, TVState> {
  final GetAiringTodayTVs _getAiringTodayTV;
  GetAiringTodayTVsBloc(this._getAiringTodayTV) : super(TVLoading()) {
    on<OnAiringTodayTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getAiringTodayTV.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class GetOnTheAirTVsBloc extends Bloc<TVEvent, TVState> {
  final GetOnTheAirTVs _getOnTheAirTV;
  GetOnTheAirTVsBloc(this._getOnTheAirTV) : super(TVLoading()) {
    on<OnOnTheAirTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getOnTheAirTV.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class GetPopularTVsBloc extends Bloc<TVEvent, TVState> {
  final GetPopularTVs _getPopularTVs;

  GetPopularTVsBloc(this._getPopularTVs) : super(TVLoading()) {
    on<OnPopularTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getPopularTVs.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class GetTopRatedTVsBloc extends Bloc<TVEvent, TVState> {
  final GetTopRatedTVs _getTopRatedTVs;

  GetTopRatedTVsBloc(this._getTopRatedTVs) : super(TVLoading()) {
    on<OnTopRatedTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getTopRatedTVs.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class GetTVDetailBloc extends Bloc<TVEvent, TVState> {
  final GetTVDetail _getTVDetail;

  GetTVDetailBloc(this._getTVDetail) : super(TVLoading()) {
    on<OnDetailTV>((event, emit) async {
      final id = event.id;

      emit(TVLoading());
      final result = await _getTVDetail.execute(id);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVDetailHasData(data)),
      );
    });
  }
}

class GetTVRecommendationsBloc extends Bloc<TVEvent, TVState> {
  final GetTVRecommendations _getTVRecommendations;

  GetTVRecommendationsBloc(this._getTVRecommendations) : super(TVLoading()) {
    on<OnTVRecommendations>((event, emit) async {
      final id = event.id;

      emit(TVLoading());
      final result = await _getTVRecommendations.execute(id);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class GetWatchlistTVsBloc extends Bloc<TVEvent, TVState> {
  final GetWatchlistTVs _getWatchlistTVs;
  final GetWatchListTVStatus _getWatchListStatus;
  final SaveWatchlistTV _saveWatchlist;
  final RemoveWatchlistTV _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  GetWatchlistTVsBloc(
    this._getWatchlistTVs,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(TVLoading()) {
    on<OnWatchlistTVs>((event, emit) async {
      emit(TVLoading());

      final result = await _getWatchlistTVs.execute();
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
    on<OnWatchlistTVStatus>((event, emit) async {
      final id = event.id;
      emit(TVLoading());

      final result = await _getWatchListStatus.execute(id);
      emit(TVWatchlistStatus(result));
    });
    on<OnSaveWatchlistTV>((event, emit) async {
      final tv = event.tvDetail;
      emit(TVLoading());

      final result = await _saveWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistTV>((event, emit) async {
      final tv = event.tvDetail;
      emit(TVLoading());

      final result = await _removeWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVWatchlistMessage(data)),
      );
    });
  }
}

class GetSeasonDetailTVBloc extends Bloc<TVEvent, TVState> {
  final GetSeasonDetailTV _getSeasonDetailTV;

  GetSeasonDetailTVBloc(this._getSeasonDetailTV) : super(TVLoading()) {
    on<OnSeasonDetailTV>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(TVLoading());
      final result = await _getSeasonDetailTV.execute(id, seasonNumber);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVSeasonDetailHasData(data)),
      );
    });
  }
}

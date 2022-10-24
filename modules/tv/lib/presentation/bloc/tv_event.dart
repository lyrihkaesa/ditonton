part of 'tv_bloc.dart';

abstract class TVEvent extends Equatable {
  const TVEvent();

  @override
  List<Object> get props => [];
}

class OnAiringTodayTV extends TVEvent {}

class OnOnTheAirTV extends TVEvent {}

class OnPopularTV extends TVEvent {}

class OnTopRatedTV extends TVEvent {}

class OnDetailTV extends TVEvent {
  final int id;
  const OnDetailTV(this.id);

  @override
  List<Object> get props => [id];
}

class OnSeasonDetailTV extends TVEvent {
  final int id;
  final int seasonNumber;
  const OnSeasonDetailTV(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}

class OnTVRecommendations extends TVEvent {
  final int id;
  const OnTVRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnWatchlistTVs extends TVEvent {}

class OnWatchlistTVStatus extends TVEvent {
  final int id;
  const OnWatchlistTVStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistTV extends TVEvent {
  final TVDetail tvDetail;
  const OnSaveWatchlistTV(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveWatchlistTV extends TVEvent {
  final TVDetail tvDetail;
  const OnRemoveWatchlistTV(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

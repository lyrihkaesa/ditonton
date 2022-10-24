part of 'tv_bloc.dart';

abstract class TVState extends Equatable {
  const TVState();

  @override
  List<Object> get props => [];
}

class TVEmpty extends TVState {}

class TVLoading extends TVState {}

class TVError extends TVState {
  final String message;

  const TVError(this.message);

  @override
  List<Object> get props => [message];
}

class TVHasData extends TVState {
  final List<TV> result;

  const TVHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TVDetailHasData extends TVState {
  final TVDetail result;

  const TVDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TVSeasonDetailHasData extends TVState {
  final TVSeasonDetail result;

  const TVSeasonDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TVWatchlistMessage extends TVState {
  final String message;
  const TVWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class TVWatchlistStatus extends TVState {
  final bool status;
  const TVWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

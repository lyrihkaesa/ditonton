import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class GetNowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovie;
  GetNowPlayingMovieBloc(this._getNowPlayingMovie) : super(MovieLoading()) {
    on<OnNowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovie.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class GetPopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  GetPopularMoviesBloc(this._getPopularMovies) : super(MovieLoading()) {
    on<OnPopularMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class GetTopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  GetTopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieLoading()) {
    on<OnTopRatedMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class GetMovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  GetMovieDetailBloc(this._getMovieDetail) : super(MovieLoading()) {
    on<OnDetailMovie>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieDetailHasData(data)),
      );
    });
  }
}

class GetMovieRecommendationsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  GetMovieRecommendationsBloc(this._getMovieRecommendations) : super(MovieLoading()) {
    on<OnMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class GetWatchlistMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  GetWatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(MovieLoading()) {
    on<OnWatchlistMovies>((event, emit) async {
      emit(MovieLoading());

      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
    on<OnWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());

      final result = await _getWatchListStatus.execute(id);
      emit(MovieWatchlistStatus(result));
    });
    on<OnSaveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _saveWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
  }
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getAiringTodayTVs();
  Future<Either<Failure, List<TV>>> getOnTheAirTVs();
  Future<Either<Failure, List<TV>>> getPopularTVs();
  Future<Either<Failure, List<TV>>> getTopRatedTVs();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTVs(String query);
  Future<Either<Failure, TVSeasonDetail>> getSeasonDetailTV(int id, int seasonNumber);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTVs();
}

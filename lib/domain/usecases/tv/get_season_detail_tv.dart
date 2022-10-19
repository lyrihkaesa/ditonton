import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetSeasonDetailTV {
  final TVRepository repository;

  GetSeasonDetailTV(this.repository);

  Future<Either<Failure, TVSeasonDetail>> execute(id, seasonNumber) {
    return repository.getSeasonDetailTV(id, seasonNumber);
  }
}

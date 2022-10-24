import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetSeasonDetailTV {
  final TVRepository repository;

  GetSeasonDetailTV(this.repository);

  Future<Either<Failure, TVSeasonDetail>> execute(id, seasonNumber) {
    return repository.getSeasonDetailTV(id, seasonNumber);
  }
}

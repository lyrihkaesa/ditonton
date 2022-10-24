import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_episode.dart';

class TVSeasonDetail extends Equatable {
  final String airDate;
  final List<TVEpisode> episodes;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  const TVSeasonDetail({
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}

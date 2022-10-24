import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';

class TVSeasonDetailModel extends Equatable {
  final String airDate;
  final List<TVEpisodeModel> episodes;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  const TVSeasonDetailModel({
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory TVSeasonDetailModel.fromJson(Map<String, dynamic> json) => TVSeasonDetailModel(
        airDate: json["air_date"],
        episodes: List<TVEpisodeModel>.from(json["episodes"].map((x) => TVEpisodeModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episodes": episodes.map((x) => x.toJson()),
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  TVSeasonDetail toEntity() {
    return TVSeasonDetail(
      airDate: airDate,
      episodes: List<TVEpisode>.from(episodes.map((x) => x.toEntity())),
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}

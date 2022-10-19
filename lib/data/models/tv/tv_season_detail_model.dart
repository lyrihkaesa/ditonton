import 'package:ditonton/data/models/tv/tv_episode_model.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeasonDetailModel extends Equatable {
  final String airDate;
  final List<TVEpisodeModel> episodes;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  TVSeasonDetailModel({
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
      airDate: this.airDate,
      episodes: List<TVEpisode>.from(this.episodes.map((x) => x.toEntity())),
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
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

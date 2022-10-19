import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TVEpisodeModel extends Equatable {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  TVEpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVEpisodeModel.fromJson(Map<String, dynamic> json) => TVEpisodeModel(
        airDate: json["air_date"] ?? "-",
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"] ?? "",
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVEpisode toEntity() {
    return TVEpisode(
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      id: this.id,
      name: this.name,
      overview: this.overview,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

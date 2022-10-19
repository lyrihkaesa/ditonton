import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/tv_season_model.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  TVDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.firstAirDate,
    required this.episodeRuntime,
    required this.status,
    required this.tagline,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.inProduction,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> episodeRuntime;
  final List<GenreModel> genres;
  final String firstAirDate;
  final String homepage;
  final int id;
  final bool inProduction;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<TVSeasonModel> seasons;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) => TVDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        seasons: List<TVSeasonModel>.from(json["seasons"].map((x) => TVSeasonModel.fromJson(x))),
        firstAirDate: json["first_air_date"],
        episodeRuntime: List<int>.from(json["episode_run_time"]),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "first_air_date": firstAirDate,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "episode_runtime": episodeRuntime,
        "in_production": inProduction,
        "status": status,
        "tagline": tagline,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      firstAirDate: this.firstAirDate,
      episodeRuntime: this.episodeRuntime,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSessions: this.numberOfSeasons,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRuntime,
        genres,
        firstAirDate,
        homepage,
        id,
        inProduction,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        tagline,
        voteAverage,
        voteCount,
      ];
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv_season.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  final List<TVSeason> seasons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SEASON_DETAIL_TV_ROUTE,
                  arguments: season,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                  placeholder: (context, url) => const SizedBox(
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const ContainerImageError(),
                ),
              ),
            ),
          );
        },
        itemCount: seasons.length,
      ),
    );
  }
}

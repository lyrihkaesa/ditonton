import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:ditonton/presentation/pages/tv/season_detail_tv_page.dart';
import 'package:ditonton/presentation/widgets/container_image_error.dart';
import 'package:flutter/material.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  final List<TVSeason> seasons;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  SeasonDetailTVPage.ROUTE_NAME,
                  arguments: season,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                  placeholder: (context, url) => Container(
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => ContainerImageError(),
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

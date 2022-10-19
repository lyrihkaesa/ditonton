import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/widgets/container_image_error.dart';
import 'package:flutter/material.dart';

class RecommendationTVList extends StatelessWidget {
  const RecommendationTVList({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  final List<TV> recommendations;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
        itemCount: recommendations.length,
      ),
    );
  }
}

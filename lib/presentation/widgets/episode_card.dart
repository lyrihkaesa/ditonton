import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/presentation/widgets/container_image_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final TVEpisode episode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                placeholder: (context, url) => Container(
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => ContainerImageError(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  episode.name,
                  style: kSubtitle,
                ),
                Text(
                  episode.airDate,
                  style: kBodyText,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: episode.voteAverage / 2,
                      itemCount: 5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: kMikadoYellow,
                      ),
                      itemSize: 24,
                    ),
                    Text('${episode.voteAverage}')
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  episode.overview,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

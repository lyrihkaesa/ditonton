import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key? key,
    required this.episodes,
  }) : super(key: key);

  final List<TVEpisode> episodes;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final episode = episodes[index];
          return EpisodeCard(episode: episode);
        },
        itemCount: episodes.length,
      ),
    );
  }
}

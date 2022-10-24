import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/presentation/widgets/episode_card.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key? key,
    required this.episodes,
  }) : super(key: key);

  final List<TVEpisode> episodes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return EpisodeCard(episode: episode);
      },
      itemCount: episodes.length,
    );
  }
}

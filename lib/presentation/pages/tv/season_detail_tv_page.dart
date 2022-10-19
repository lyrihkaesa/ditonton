// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/presentation/provider/tv/season_detail_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_list.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:provider/provider.dart';

class SeasonDetailTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/season-detail-tv';

  final TVSeason season;

  const SeasonDetailTVPage({
    Key? key,
    required this.season,
  }) : super(key: key);

  @override
  State<SeasonDetailTVPage> createState() => _SeasonDetailTVPageState();
}

class _SeasonDetailTVPageState extends State<SeasonDetailTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final idTV = Provider.of<TVDetailNotifier>(context, listen: false).tv.id;
      Provider.of<TVSeasonDetailNotifier>(context, listen: false).fetchTVSeasonDetail(idTV, widget.season.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TVSeasonDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeasonDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeasonDetailState == RequestState.Loaded) {
            final tvSeasonDetail = provider.tvSeasonDetail;
            return SafeArea(
              child: Center(
                child: TVSeasonDetailContent(tvSeasonDetail),
              ),
            );
          } else {
            return Center(
              child: Text(
                provider.message,
                key: Key("error_message"),
              ),
            );
          }
        },
      ),
    );
  }
}

class TVSeasonDetailContent extends StatelessWidget {
  final TVSeasonDetail tvSeasonDetail;

  TVSeasonDetailContent(this.tvSeasonDetail);

  @override
  Widget build(BuildContext context) {
    final tv = Provider.of<TVDetailNotifier>(context).tv;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeasonDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeasonDetail.name,
                              style: kHeading5,
                            ),
                            Text(tv.name),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            SizedBox(height: 10),
                            Text(
                              tvSeasonDetail.overview.isEmpty
                                  ? 'This TV Series Overview is empty.'
                                  : tvSeasonDetail.overview.toString(),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episode',
                              style: kHeading6,
                            ),
                            SizedBox(height: 10),
                            EpisodeList(episodes: tvSeasonDetail.episodes),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

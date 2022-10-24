// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_season.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/episode_list.dart';

class SeasonDetailTVPage extends StatefulWidget {
  final TVSeason season;

  const SeasonDetailTVPage({super.key, required this.season});

  @override
  State<SeasonDetailTVPage> createState() => _SeasonDetailTVPageState();
}

class _SeasonDetailTVPageState extends State<SeasonDetailTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = BlocProvider.of<GetTVDetailBloc>(context).state;
      if (state is TVDetailHasData) {
        context.read<GetSeasonDetailTVBloc>().add(OnSeasonDetailTV(state.result.id, widget.season.seasonNumber));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetSeasonDetailTVBloc, TVState>(
        builder: (context, state) {
          if (state is TVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeasonDetailHasData) {
            final tvSeasonDetail = state.result;
            return SafeArea(
              child: Center(
                child: TVSeasonDetailContent(tvSeasonDetail),
              ),
            );
          } else if (state is TVError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              key: Key('empty'),
              child: Text('Empty Data'),
            );
          }
        },
      ),
    );
  }
}

class TVSeasonDetailContent extends StatelessWidget {
  final TVSeasonDetail tvSeasonDetail;

  const TVSeasonDetailContent(this.tvSeasonDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeasonDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
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
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            BlocBuilder<GetSeasonDetailTVBloc, TVState>(
                              builder: (context, state) {
                                if (state is TVDetailHasData) {
                                  return Text(state.result.name);
                                } else {
                                  return const Text('Unknown Title');
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              tvSeasonDetail.overview.isEmpty
                                  ? 'This TV Series Overview is empty.'
                                  : tvSeasonDetail.overview.toString(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Episode',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
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
              icon: const Icon(Icons.arrow_back),
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

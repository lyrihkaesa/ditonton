import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/recommendation_tv_list.dart';
import 'package:tv/presentation/widgets/season_list.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  const TVDetailPage({super.key, required this.id});

  @override
  State<TVDetailPage> createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetTVDetailBloc>().add(OnDetailTV(widget.id));
      context.read<GetTVRecommendationsBloc>().add(OnTVRecommendations(widget.id));
      context.read<GetWatchlistTVsBloc>().add(OnWatchlistTVStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetTVDetailBloc, TVState>(
        builder: (context, state) {
          if (state is TVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVDetailHasData) {
            final tv = state.result;
            final tvRecommendations = context.select<GetTVRecommendationsBloc, List<TV>>((result) {
              final state = result.state;
              return state is TVHasData ? state.result : [];
            });
            final isAddedToWatchlist = context.select<GetWatchlistTVsBloc, bool>((result) {
              final state = result.state;
              return state is TVWatchlistStatus ? state.status : false;
            });
            return SafeArea(
              child: DetailContent(tv, tvRecommendations, isAddedToWatchlist),
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

class DetailContent extends StatelessWidget {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.recommendations, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context.read<GetWatchlistTVsBloc>().add(OnSaveWatchlistTV(tv));
                                } else {
                                  context.read<GetWatchlistTVsBloc>().add(OnRemoveWatchlistTV(tv));
                                }
                                String message = '';

                                message = !isAddedWatchlist
                                    ? GetWatchlistTVsBloc.watchlistAddSuccessMessage
                                    : GetWatchlistTVsBloc.watchlistRemoveSuccessMessage;

                                final state = BlocProvider.of<GetWatchlistTVsBloc>(context).state;

                                if (state is TVError) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(duration: const Duration(milliseconds: 500), content: Text(message)));
                                  // Load new status
                                  BlocProvider.of<GetWatchlistTVsBloc>(context).add(OnWatchlistTVStatus(tv.id));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(tv.firstAirDate),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              tv.overview.isEmpty ? 'This TV Series Overview is empty.' : tv.overview.toString(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SeasonList(seasons: tv.seasons),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            BlocBuilder<GetTVRecommendationsBloc, TVState>(
                              builder: (context, state) {
                                if (state is TVLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TVHasData) {
                                  return RecommendationTVList(recommendations: recommendations);
                                } else if (state is TVError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return Container(
                                    key: const Key('empty_recommendation'),
                                  );
                                }
                              },
                            ),
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

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

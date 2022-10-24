import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/recommendation_movie_list.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetMovieDetailBloc>().add(OnDetailMovie(widget.id));
      context.read<GetMovieRecommendationsBloc>().add(OnMovieRecommendations(widget.id));
      context.read<GetWatchlistMoviesBloc>().add(OnWatchlistMovieStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetMovieDetailBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.result;
            final movieRecommendations = context.select<GetMovieRecommendationsBloc, List<Movie>>((result) {
              final state = result.state;
              return state is MovieHasData ? state.result : [];
            });
            final isAddedToWatchlist = context.select<GetWatchlistMoviesBloc, bool>((result) {
              final state = result.state;
              return state is MovieWatchlistStatus ? state.status : false;
            });
            return SafeArea(
              child: DetailContent(
                movie,
                movieRecommendations,
                isAddedToWatchlist,
              ),
            );
          } else {
            return const Text("Failed");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                              movie.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context.read<GetWatchlistMoviesBloc>().add(OnSaveWatchlistMovie(movie));
                                } else {
                                  context.read<GetWatchlistMoviesBloc>().add(OnRemoveWatchlistMovie(movie));
                                }

                                String message = '';

                                message = !isAddedWatchlist
                                    ? GetWatchlistMoviesBloc.watchlistAddSuccessMessage
                                    : GetWatchlistMoviesBloc.watchlistRemoveSuccessMessage;

                                final state = BlocProvider.of<GetWatchlistMoviesBloc>(context).state;

                                if (state is MovieError) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                  BlocProvider.of<GetWatchlistMoviesBloc>(context)
                                      .add(OnWatchlistMovieStatus(movie.id));
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
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              movie.overview.isEmpty ? 'This Movie Overview is empty.' : movie.overview.toString(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            BlocBuilder<GetMovieRecommendationsBloc, MovieState>(
                              builder: (context, state) {
                                if (state is MovieLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else if (state is MovieHasData) {
                                  return RecommendationMovieList(recommendations: recommendations);
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
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

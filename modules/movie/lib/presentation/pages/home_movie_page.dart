import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});
  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetNowPlayingMovieBloc>().add(OnNowPlayingMovie());
      context.read<GetPopularMoviesBloc>().add(OnPopularMovie());
      context.read<GetTopRatedMoviesBloc>().add(OnTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              onTap: () {
                Navigator.pushNamed(context, HOME_TV_ROUTE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_MOVIE_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: Theme.of(context).textTheme.headline6,
              ),
              BlocBuilder<GetNowPlayingMovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieLoading) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MovieHasData) {
                  return MovieList(state.result);
                } else {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_now_playing_movies'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                key: const Key(POPULAR_MOVIE_ROUTE),
                onTap: () => Navigator.pushNamed(context, POPULAR_MOVIE_ROUTE),
              ),
              BlocBuilder<GetPopularMoviesBloc, MovieState>(builder: (context, state) {
                if (state is MovieLoading) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MovieHasData) {
                  return MovieList(state.result);
                } else {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_popular_movies'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                key: const Key(TOP_RATED_MOVIE_ROUTE),
                onTap: () => Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE),
              ),
              BlocBuilder<GetTopRatedMoviesBloc, MovieState>(builder: (context, state) {
                if (state is MovieLoading) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MovieHasData) {
                  return MovieList(state.result);
                } else {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_top_rated_movies'),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, Key? key, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        InkWell(
          key: key,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_MOVIE_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const SizedBox(
                    width: 133,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const ContainerImageErrorHome(),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

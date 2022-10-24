import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({super.key});
  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetAiringTodayTVsBloc>().add(OnAiringTodayTV());
      context.read<GetOnTheAirTVsBloc>().add(OnOnTheAirTV());
      context.read<GetPopularTVsBloc>().add(OnPopularTV());
      context.read<GetTopRatedTVsBloc>().add(OnTopRatedTV());
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
                Navigator.pushNamed(context, HOME_MOVIE_ROUTE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
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
        title: const Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
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
              _buildSubHeading(
                title: 'Airing Today',
                key: const Key(AIRING_TODAY_TV_ROUTE),
                onTap: () => Navigator.pushNamed(context, AIRING_TODAY_TV_ROUTE),
              ),
              BlocBuilder<GetAiringTodayTVsBloc, TVState>(
                builder: (context, state) {
                  if (state is TVLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TVHasData) {
                    return TVList(state.result);
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Failed connect to network',
                          key: Key('failed_airing_today_tvs'),
                        ),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'On The Air',
                key: const Key(ON_THE_AIR_TV_ROUTE),
                onTap: () => Navigator.pushNamed(context, ON_THE_AIR_TV_ROUTE),
              ),
              BlocBuilder<GetOnTheAirTVsBloc, TVState>(
                builder: (context, state) {
                  if (state is TVLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TVHasData) {
                    return TVList(state.result);
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Failed connect to network',
                          key: Key('failed_on_the_air_tvs'),
                        ),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                key: const Key(POPULAR_TV_ROUTE),
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<GetPopularTVsBloc, TVState>(
                builder: (context, state) {
                  if (state is TVLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TVHasData) {
                    return TVList(state.result);
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Failed connect to network',
                          key: Key('failed_popular_tvs'),
                        ),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                key: const Key(TOP_RATED_TV_ROUTE),
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<GetTopRatedTVsBloc, TVState>(
                builder: (context, state) {
                  if (state is TVLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TVHasData) {
                    return TVList(state.result);
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Failed connect to network',
                          key: Key('failed_top_rated_tvs'),
                        ),
                      ),
                    );
                  }
                },
              ),
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

class TVList extends StatelessWidget {
  final List<TV> tvs;

  const TVList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_TV_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
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
        itemCount: tvs.length,
      ),
    );
  }
}

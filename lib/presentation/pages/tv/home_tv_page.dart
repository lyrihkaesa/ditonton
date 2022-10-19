import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/airing_today_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/on_the_air_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/container_image_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TVListNotifier>(context, listen: false)
      ..fetchAiringTodayTVs()
      ..fetchOnTheAirTVs()
      ..fetchPopularTVs()
      ..fetchTopRatedTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
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
                onTap: () => Navigator.pushNamed(context, AiringTodayTVsPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.Loading) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.airingTodayTVs);
                } else {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_airing_today_tvs'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'On The Air',
                onTap: () => Navigator.pushNamed(context, OnTheAirTVsPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirState;
                if (state == RequestState.Loading) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.onTheAirTVs);
                } else {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_on_the_air_tvs'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularTVsPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.popularTVsState;
                if (state == RequestState.Loading) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.popularTVs);
                } else {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_popular_tvs'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedTVsPage.ROUTE_NAME),
              ),
              Consumer<TVListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTVsState;
                if (state == RequestState.Loading) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.topRatedTVs);
                } else {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_top_rated_tvs'),
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tvs;

  TVList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Container(
                    child: Container(
                      width: 133,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => ContainerImageErrorHome(),
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

import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final List<Tab> _myTab = [
    Tab(
      text: 'Movie',
    ),
    Tab(
      text: 'TV Series',
    ),
  ];

  final List<Widget> __myTabBarView = [
    WatchlistMoviesPage(),
    WatchlistTVsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return DefaultTabController(
          length: _myTab.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Watchlist'),
              bottom: TabBar(
                tabs: _myTab,
              ),
            ),
            body: TabBarView(
              children: __myTabBarView,
            ),
          ),
        );
      },
    );
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistTVsPage extends StatefulWidget {
  const WatchlistTVsPage({super.key});

  @override
  State<WatchlistTVsPage> createState() => _WatchlistTVsPageState();
}

class _WatchlistTVsPageState extends State<WatchlistTVsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<GetWatchlistTVsBloc>().add(OnWatchlistTVs()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<GetWatchlistTVsBloc>().add(OnWatchlistTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<GetWatchlistTVsBloc, TVState>(
        builder: (context, state) {
          if (state is TVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.result[index];
                return TVCard(tv);
              },
              itemCount: state.result.length,
            );
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

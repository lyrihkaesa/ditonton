import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class AiringTodayTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv';

  const AiringTodayTVsPage({super.key});

  @override
  State<AiringTodayTVsPage> createState() => _AiringTodayTVsPageState();
}

class _AiringTodayTVsPageState extends State<AiringTodayTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<GetAiringTodayTVsBloc>().add(OnAiringTodayTV()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TVs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetAiringTodayTVsBloc, TVState>(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_train_flutter/features/home/bloc/home_bloc.dart';
import 'package:next_train_flutter/features/home/models/station_search_result.dart';
import 'package:next_train_flutter/network/network_client.dart';
import 'package:next_train_flutter/features/home/data/local_repository.dart';
import 'package:next_train_flutter/features/home/data/sation_info_repository.dart';
import 'package:next_train_flutter/features/home/presentation/arrival_list_widget.dart';
import 'package:http/http.dart' as http;
import 'package:next_train_flutter/widgets/sliver_separated_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiRepositoryProvider(
            providers: [
          RepositoryProvider<SubwayStationInfoResposiory>(
              create: (context) =>
                  SubwayStationInfoResposiory(NetworkClient(httpClient: http.Client()))),
          RepositoryProvider<PreferencesLocalRepository>(
              create: (context) => PreferencesLocalRepository())
        ],
            child: BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(context.read<SubwayStationInfoResposiory>(),
                    context.read<PreferencesLocalRepository>())
                  ..add(GetLatest()),
                child: const HomeLayoutWidget())));
  }
}

class HomeLayoutWidget extends StatelessWidget {
  const HomeLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return SliverAppBar.large(
          title: state.searchShown ? const SearchWidget() : TitleWidget(title: state.stationName),
          actions: [
            IconButton(
                onPressed: () => context.read<HomeBloc>().add(ToggleSearch()),
                icon: state.searchShown ? const Icon(Icons.close) : const Icon(Icons.search))
          ],
        );
      }),
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state.searchShown) {
          return SearchResults(results: state.searchResults);
        }
        switch (state.status) {
          case HomeStatus.loading:
            return const LoadingWidget();
          case HomeStatus.success:
            return ArrivalListWidget(data: state.data);
          case HomeStatus.error:
            return ErrorWidget(icon: state.error?.icon, message: state.error?.message);
          case HomeStatus.initial:
            return const SliverFillRemaining();
        }
      }),
    ]);
  }
}

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.w800));
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        context.read<HomeBloc>().add(Search(value));
      },
      decoration: const InputDecoration(hintText: '지하철역명', border: InputBorder.none),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final IconData? icon;
  final String? message;

  const ErrorWidget({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: 16),
          Text(message ?? ''),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              onPressed: () => context.read<HomeBloc>().add(GetLatest()),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry')),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
  }
}

class SearchResults extends StatelessWidget {
  final List<StationSearchResult> results;

  const SearchResults({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return SliverSeparatedListView(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          final stationName = results[index].title;
          return ListTile(
            leading: Icon(Icons.train, color: Theme.of(context).disabledColor),
            title: Text(stationName),
            onTap: () => context.read<HomeBloc>().add(SetStation(stationName)),
          );
        });
  }
}

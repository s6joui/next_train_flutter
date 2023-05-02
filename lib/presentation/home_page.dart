import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_train_flutter/bloc/arrivals_bloc.dart';
import 'package:next_train_flutter/common/network/network_client.dart';
import 'package:next_train_flutter/data/sation_info_repository.dart';
import 'package:next_train_flutter/presentation/arrival_list_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepositoryProvider(
            create: (context) => SubwayStationInfoResposiory(
                NetworkClient(httpClient: http.Client())),
            child: BlocProvider<ArrivalsBloc>(
                create: (context) =>
                    ArrivalsBloc(context.read<SubwayStationInfoResposiory>())
                      ..add(GetLatest('sa')),
                child: const HomeLayoutWidget())));
  }
}

class HomeLayoutWidget extends StatelessWidget {
  const HomeLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar.large(
        title: const Text('Next train',
            style: TextStyle(fontWeight: FontWeight.w800)),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.search))],
      ),
      BlocBuilder<ArrivalsBloc, ArrivalsState>(builder: (context, state) {
        if (state is ArrivalsLoaded) {
          return ArrivalListWidget(data: state.data);
        }
        if (state is ArrivalsError) {
          return ErrorWidget(icon: state.icon, message: state.message);
        }
        return const LoadingWidget();
      }),
    ]);
  }
}

class ErrorWidget extends StatelessWidget {
  final IconData icon;
  final String message;

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
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              onPressed: () =>
                  context.read<ArrivalsBloc>().add(GetLatest('홍대입구')),
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
    return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_train_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:next_train_flutter/features/home/models/home_error.dart';
import 'mocks/mock_repository.dart';

void main() {
  group('Home tests', () {
    late HomeBloc homeBloc;
    late MockStationInfoRepository stationRepository;
    late MockLocalRepository localRepository;

    setUp(() {
      stationRepository = MockStationInfoRepository();
      localRepository = MockLocalRepository();
      homeBloc = HomeBloc(stationRepository, localRepository);
    });

    blocTest<HomeBloc, HomeState>(
      'emits loading status and success when successfully loading Home.',
      build: () {
        localRepository.stationName = '홍대입구';
        return homeBloc;
      },
      act: (bloc) => bloc.add(RequestedLatestData()),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(status: HomeStatus.success, data: [], stationName: '홍대입구')
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits loading status and error when failing to load Home.',
      build: () {
        stationRepository.shouldError = true;
        return homeBloc;
      },
      act: (bloc) => bloc.add(RequestedLatestData()),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(
            status: HomeStatus.error,
            error: HomeError(Icons.train, 'Oops! Something went wrong. Please try again.'))
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits loading and loading with searchShown when no station saved. (first run)',
      build: () {
        localRepository.stationName = null;
        return homeBloc;
      },
      act: (bloc) => bloc.add(RequestedLatestData()),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(status: HomeStatus.loading, searchShown: true)
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits state with search query when typing search query',
      build: () => homeBloc,
      act: (bloc) => bloc.add(Searched('hi')),
      expect: () => [const HomeState(status: HomeStatus.initial, searchQuery: 'hi', searchShown: true)],
    );

    blocTest<HomeBloc, HomeState>(
      'emits state to hide search, loading and success when selecting a station from search results',
      build: () => homeBloc,
      act: (bloc) => bloc.add(ChangedStation('대림')),
      expect: () => [
        const HomeState(status: HomeStatus.initial, searchShown: false, stationName: '대림'),
        const HomeState(status: HomeStatus.loading, stationName: '대림'),
        const HomeState(status: HomeStatus.success, data: [], stationName: '대림')
      ],
    );

    tearDown(() {
      homeBloc.close();
    });
  });
}

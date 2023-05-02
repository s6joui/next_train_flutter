import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_train_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
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
      'emits [HomeLoading, HomeLoaded] when successfully loading Home.',
      build: () {
        localRepository.stationName = '홍대입구';
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetLatest()),
      expect: () => [HomeLoading(), HomeLoaded(const [])],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when failing to load Home.',
      build: () {
        stationRepository.shouldError = true;
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetLatest()),
      expect: () =>
          [HomeLoading(), HomeError(Icons.train, 'Oops! Something went wrong. Please try again.')],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeSearch] when no station saved. (first run)',
      build: () {
        localRepository.stationName = null;
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetLatest()),
      expect: () => [HomeLoading(), HomeSearch('', const [])],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeSearch] when typing search query',
      build: () => homeBloc,
      act: (bloc) => bloc.add(Search('hi')),
      expect: () => [HomeSearch('hi', const [])],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeLoaded] when selecting a station from search results',
      build: () => homeBloc,
      act: (bloc) => bloc.add(SetStation('대림')),
      expect: () => [HomeLoading(), HomeLoaded(const [])],
    );

    tearDown(() {
      homeBloc.close();
    });
  });
}

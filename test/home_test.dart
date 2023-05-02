import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_train_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'mocks/mock_repository.dart';

void main() {
  group('Home test', () {
    late HomeBloc homeBloc;
    MockStationInfoRepository stationRepository;
    MockLocalRepository localRepository;

    setUp(() {
      stationRepository = MockStationInfoRepository();
      localRepository = MockLocalRepository();
      homeBloc = HomeBloc(stationRepository, localRepository);
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeLoaded] when successfully loading Home.',
      build: () => homeBloc,
      act: (bloc) => bloc.add(GetLatest('홍대입구')),
      expect: () => [
        HomeLoading(),
        HomeLoaded(MockStationInfoRepository.mockStationInfo['홍대입구']!)
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when failing to load Home.',
      build: () => homeBloc,
      act: (bloc) => bloc.add(GetLatest('dasdsa')),
      expect: () => [
        HomeLoading(),
        HomeError(Icons.error, 'Oops! Something went wrong. Please try again.')
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, SearchShown] when station name is unknown. (first run)',
      build: () => homeBloc,
      act: (bloc) => bloc.add(GetLatest()),
      expect: () => [
        HomeLoading(),
        HomeError(Icons.error, 'Oops! Something went wrong. Please try again.')
      ],
    );

    tearDown(() {
      homeBloc.close();
    });
  });
}

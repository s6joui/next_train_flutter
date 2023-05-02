import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_train_flutter/bloc/arrivals_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'mocks/mock_arrivals_repository.dart';

void main() {
  group('Arrivals test', () {
    late ArrivalsBloc arrivalsBloc;
    MockArrivalsRepository repository;

    setUp(() {
      repository = MockArrivalsRepository();
      arrivalsBloc = ArrivalsBloc(repository);
    });

    blocTest<ArrivalsBloc, ArrivalsState>(
      'emits [ArrivalsLoading, ArrivalsLoaded] when successfully loading arrivals.',
      build: () => arrivalsBloc,
      act: (bloc) => bloc.add(GetLatest('홍대입구')),
      expect: () => [
        ArrivalsLoading(),
        ArrivalsLoaded(MockArrivalsRepository.mockStationInfo['홍대입구']!)
      ],
    );

    blocTest<ArrivalsBloc, ArrivalsState>(
      'emits [ArrivalsLoading, ArrivalsError] when failing to load arrivals.',
      build: () => arrivalsBloc,
      act: (bloc) => bloc.add(GetLatest('dasdsa')),
      expect: () => [
        ArrivalsLoading(),
        ArrivalsError(
            Icons.error, 'Oops! Something went wrong. Please try again.')
      ],
    );

    tearDown(() {
      arrivalsBloc.close();
    });
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:next_train_flutter/features/home/data/local_repository.dart';
import 'package:next_train_flutter/features/home/data/sation_info_repository.dart';
import 'package:next_train_flutter/features/home/models/home_error.dart';
import 'package:next_train_flutter/features/home/models/station_search_result.dart';
import 'package:next_train_flutter/features/home/models/line_info.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StationInfoRepository stationRepository;
  final LocalRepository localRepository;

  HomeBloc(this.stationRepository, this.localRepository)
      : super(const HomeState(status: HomeStatus.initial, searchShown: false)) {
    on<RequestedLatestData>(_getLatest);
    on<ToggledSearch>(_toggleSearch);
    on<Searched>(_search);
    on<ChangedStation>(_setStation);
  }

  void _getLatest(RequestedLatestData event, Emitter<HomeState> emit) async {
    final stationName = await localRepository.getStationName();

    emit(state.copyWith(status: HomeStatus.loading, stationName: stationName));

    if (stationName == null) {
      emit(state.copyWith(searchShown: true));
      return;
    }

    try {
      final data = await stationRepository.fetchLatestInfo(stationName);
      emit(state.copyWith(status: HomeStatus.success, data: data, stationName: stationName));
    } catch (e) {
      const error = HomeError(Icons.train, 'Oops! Something went wrong. Please try again.');
      emit(state.copyWith(status: HomeStatus.error, error: error));
    }
  }

  void _toggleSearch(ToggledSearch event, Emitter<HomeState> emit) {
    emit(state.copyWith(searchShown: !state.searchShown, searchQuery: '', searchResults: const []));
  }

  void _search(Searched event, Emitter<HomeState> emit) {
    if (event.searchQuery.isNotEmpty) {
      final regex = getRegExp(
          event.searchQuery,
          RegExpOptions(
              initialSearch: true,
              startsWith: true,
              ignoreCase: true,
              ignoreSpace: true)); // Korean search

      final results = stationRepository
          .getStationNames()
          .where((name) => regex.hasMatch(name))
          .map((name) => StationSearchResult(name))
          .toList();

      emit(state.copyWith(searchShown: true, searchQuery: event.searchQuery, searchResults: results));
    } else {
      emit(state.copyWith(searchShown: true, searchQuery: '', searchResults: const []));
    }
  }

  void _setStation(ChangedStation event, Emitter<HomeState> emit) {
    localRepository.setStationName(event.name);
    emit(state.copyWith(
        stationName: event.name, searchShown: false, searchQuery: '', searchResults: const []));
    add(RequestedLatestData());
  }
}

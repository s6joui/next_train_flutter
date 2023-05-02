// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:next_train_flutter/features/home/data/local_repository.dart';
import 'package:next_train_flutter/features/home/data/sation_info_repository.dart';
import 'package:next_train_flutter/features/home/models/station_search_result.dart';
import 'package:next_train_flutter/features/home/models/line_info.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StationInfoRepository stationRepository;
  final LocalRepository localRepository;

  var _isSearchVisible = false;

  HomeBloc(this.stationRepository, this.localRepository) : super(HomeInitial()) {
    on<GetLatest>(_getLatest);
    on<ToggleSearch>(_toggleSearch);
    on<Search>(_search);
    on<SetStation>(_setStation);
  }

  void _getLatest(GetLatest event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final stationName = await localRepository.getStationName();

    if (stationName == null) {
      emit(HomeSearch('', const []));
      return;
    }

    _isSearchVisible = false;

    try {
      final data = await stationRepository.fetchLatestInfo(stationName);
      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError(Icons.train, 'Oops! Something went wrong. Please try again.'));
    }
  }

  void _toggleSearch(ToggleSearch event, Emitter<HomeState> emit) {
    _isSearchVisible = !_isSearchVisible;
    if (_isSearchVisible) {
      emit(HomeSearch('', const []));
    } else {
      add(GetLatest());
    }
  }

  void _search(Search event, Emitter<HomeState> emit) {
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

      emit(HomeSearch(event.searchQuery, results));
    } else {
      emit(HomeSearch(event.searchQuery, const []));
    }
  }

  void _setStation(SetStation event, Emitter<HomeState> emit) {
    localRepository.setStationName(event.name);
    add(GetLatest());
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_train_flutter/data/sation_info_repository.dart';
import 'package:next_train_flutter/models/line_info.dart';

part 'arrivals_event.dart';
part 'arrivals_state.dart';

class ArrivalsBloc extends Bloc<ArrivalsEvent, ArrivalsState> {
  final StationInfoRepository repository;

  ArrivalsBloc(
    this.repository,
  ) : super(ArrivalsInitial()) {
    on<ArrivalsEvent>((event, emit) async {
      if (event is GetLatest) {
        emit(ArrivalsLoading());
        try {
          final info = await repository.fetchLatestInfo(event.stationName);
          emit(ArrivalsLoaded(info));
        } catch (e) {
          emit(ArrivalsError(
              Icons.train, 'Oops! Something went wrong. Please try again.'));
        }
      }
    });
  }
}

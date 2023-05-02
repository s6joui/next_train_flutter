import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'arrivals_event.dart';
part 'arrivals_state.dart';

class ArrivalsBloc extends Bloc<ArrivalsEvent, ArrivalsState> {
  ArrivalsBloc() : super(ArrivalsInitial()) {
    on<ArrivalsEvent>((event, emit) {});
  }
}

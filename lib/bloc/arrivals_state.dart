part of 'arrivals_bloc.dart';

@immutable
abstract class ArrivalsState {}

class ArrivalsInitial extends ArrivalsState {}

class ArrivalsLoading extends ArrivalsState {}

class ArrivalsLoaded extends ArrivalsState {}

class ArrivalsError extends ArrivalsState {
  final IconData icon;
  final String? message;

  ArrivalsError(this.icon, this.message);
}

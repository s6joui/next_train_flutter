part of 'arrivals_bloc.dart';

@immutable
abstract class ArrivalsState extends Equatable {}

class ArrivalsInitial extends ArrivalsState {
  @override
  List<Object?> get props => [];
}

class ArrivalsLoading extends ArrivalsState {
  @override
  List<Object?> get props => [];
}

class ArrivalsLoaded extends ArrivalsState {
  @override
  List<Object?> get props => [];
}

class ArrivalsError extends ArrivalsState {
  final IconData icon;
  final String? message;

  ArrivalsError(this.icon, this.message);

  @override
  List<Object?> get props => [icon, message];
}

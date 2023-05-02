part of 'arrivals_bloc.dart';

@immutable
abstract class ArrivalsEvent extends Equatable {}

class GetArrivals extends ArrivalsEvent {
  @override
  List<Object?> get props => [];
}

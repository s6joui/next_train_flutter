part of 'arrivals_bloc.dart';

@immutable
abstract class ArrivalsEvent extends Equatable {}

class GetLatest extends ArrivalsEvent {
  final String stationName;

  GetLatest(this.stationName);

  @override
  List<Object?> get props => [stationName];
}

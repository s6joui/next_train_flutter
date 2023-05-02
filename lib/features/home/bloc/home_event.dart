part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class RequestedLatestData extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ToggledSearch extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class Searched extends HomeEvent {
  final String searchQuery;

  Searched(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}

class ChangedStation extends HomeEvent {
  final String name;

  ChangedStation(this.name);

  @override
  List<Object?> get props => [name];
}

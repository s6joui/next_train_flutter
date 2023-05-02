part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class GetLatest extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ToggleSearch extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class Search extends HomeEvent {
  final String searchQuery;

  Search(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}

class SetStation extends HomeEvent {
  final String name;

  SetStation(this.name);

  @override
  List<Object?> get props => [name];
}

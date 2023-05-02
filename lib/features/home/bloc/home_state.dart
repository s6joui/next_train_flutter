part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<LineInfo> data;

  HomeLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class HomeError extends HomeState {
  final IconData icon;
  final String message;

  HomeError(this.icon, this.message);

  @override
  List<Object?> get props => [icon, message];
}

class HomeSearch extends HomeState {
  final String searchQuery;
  final List<StationSearchResult> results;

  HomeSearch(this.searchQuery, this.results);

  @override
  List<Object?> get props => [searchQuery, results];
}

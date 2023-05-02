// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final List<LineInfo> data;
  final String stationName;
  final HomeError? error;
  final bool searchShown;
  final String searchQuery;
  final List<StationSearchResult> searchResults;

  const HomeState(
      {required this.status,
      this.data = const [],
      this.stationName = '',
      this.error,
      this.searchShown = false,
      this.searchQuery = '',
      this.searchResults = const []});

  @override
  List<Object?> get props => [status, data, stationName, error, searchShown, searchQuery, searchResults];

  HomeState copyWith({
    HomeStatus? status,
    List<LineInfo>? data,
    String? stationName,
    HomeError? error,
    bool? searchShown,
    String? searchQuery,
    List<StationSearchResult>? searchResults,
  }) {
    return HomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      stationName: stationName ?? this.stationName,
      error: error ?? this.error,
      searchShown: searchShown ?? this.searchShown,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

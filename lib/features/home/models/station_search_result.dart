import 'package:equatable/equatable.dart';

class StationSearchResult extends Equatable {
  final String title;

  const StationSearchResult(this.title);
  
  @override
  List<Object?> get props => [title];
}

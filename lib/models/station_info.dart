// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:next_train_flutter/models/line_info.dart';

class StationInfo {
  final int id;
  final String name;
  final List<LineInfo> lines;
  const StationInfo({
    required this.id,
    required this.name,
    required this.lines,
  });
}

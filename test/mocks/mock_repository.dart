import 'package:next_train_flutter/features/home/data/local_repository.dart';
import 'package:next_train_flutter/features/home/data/sation_info_repository.dart';
import 'package:next_train_flutter/features/home/models/line_info.dart';

class MockStationInfoRepository extends StationInfoRepository {
  bool shouldError = false;

  @override
  Future<List<LineInfo>> fetchLatestInfo(String stationName) async {
    if (shouldError) {
      return Future.error('error');
    }
    return Future.value([]);
  }

  @override
  Set<String> getStationNames() {
    return {};
  }
}

class MockLocalRepository extends LocalRepository {
  String? stationName = '';

  @override
  void setStationName(String stationName) {}

  @override
  Future<String?> getStationName() {
    return Future.value(stationName);
  }

  @override
  void clear() {}
}

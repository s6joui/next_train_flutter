import 'package:next_train_flutter/features/home/data/local_repository.dart';
import 'package:next_train_flutter/features/home/data/sation_info_repository.dart';
import 'package:next_train_flutter/features/home/models/line_info.dart';

class MockStationInfoRepository extends StationInfoRepository {
  static const Map<String, List<LineInfo>> mockStationInfo = {'홍대입구': []};

  @override
  Future<List<LineInfo>> fetchLatestInfo(String stationName) async {
    return Future.delayed(
        const Duration(seconds: 0), () => mockStationInfo[stationName]!);
  }
}

class MockLocalRepository extends LocalRepository {

  @override
  String? getStationName() {
    throw UnimplementedError();
  }

  @override
  void setStationName(String stationName) {
  }
  
  @override
  void clear() {
  }

}
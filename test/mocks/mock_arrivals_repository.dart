import 'package:next_train_flutter/data/sation_info_repository.dart';
import 'package:next_train_flutter/models/station_info.dart';

class MockArrivalsRepository extends StationInfoRepository {
  static const Map<String, StationInfo> mockStationInfo = {
    '홍대입구': StationInfo(id: 1000200239, name: '홍대입구', lines: [])
  };

  @override
  Future<StationInfo> fetchLatestInfo(String stationName) async {
    return Future.delayed(
        const Duration(seconds: 0), () => mockStationInfo[stationName]!);
  }
}

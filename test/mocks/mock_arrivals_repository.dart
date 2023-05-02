import 'package:next_train_flutter/data/sation_info_repository.dart';
import 'package:next_train_flutter/models/line_info.dart';

class MockArrivalsRepository extends StationInfoRepository {
  static const Map<String, List<LineInfo>> mockStationInfo = {'홍대입구': []};

  @override
  Future<List<LineInfo>> fetchLatestInfo(String stationName) async {
    return Future.delayed(
        const Duration(seconds: 0), () => mockStationInfo[stationName]!);
  }
}

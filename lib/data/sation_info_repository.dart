import 'package:next_train_flutter/models/line_info.dart';
import 'package:next_train_flutter/models/station_info.dart';

abstract class StationInfoRepository {
  Future<StationInfo> fetchLatestInfo(String stationName);
}

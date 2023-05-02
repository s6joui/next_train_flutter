import 'package:next_train_flutter/common/csv_reader.dart';
import 'package:next_train_flutter/common/network/network_client.dart';
import 'package:next_train_flutter/data/arrival_info.dart';
import 'package:next_train_flutter/data/subway_api.dart';
import 'package:next_train_flutter/models/line_info.dart';
import 'package:next_train_flutter/models/train.dart';
import 'package:next_train_flutter/utils/line_colors.dart';

abstract class StationInfoRepository {
  Future<List<LineInfo>> fetchLatestInfo(String stationName);
}

class SubwayStationInfoResposiory extends StationInfoRepository {
  final NetworkClient networkClient;
  final CsvReader csvReader = CsvReader();

  final Map<int, String> _stations = {};
  final Map<String, String> _lines = {};
  final Set<String> stationNames = {};

  SubwayStationInfoResposiory(this.networkClient) {
    _readCsvStationData();
  }

  @override
  Future<List<LineInfo>> fetchLatestInfo(String stationName) async {
    await Future.delayed(const Duration(
        seconds: 2)); // Short delay to avoid calling the API too frequently
    final ArrivalsRequest request = ArrivalsRequest(stationName: stationName);
    try {
      final json = await networkClient.send(request);
      final infoResponse = ArrivalsResponse.fromJson(json);
      if (infoResponse.realtimeArrivalList == null ||
          infoResponse.realtimeArrivalList?.isEmpty == true) {
        throw Exception('No data available');
      }
      List<LineInfo>? lineInfo = _groupArrivalInfoByLine(infoResponse);
      if (lineInfo == null || lineInfo.isEmpty) {
        throw Exception('Data couldn\'t be processed');
      }
      return lineInfo;
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  List<LineInfo>? _groupArrivalInfoByLine(ArrivalsResponse infoResponse) {
    List<ArrivalInfo>? list = infoResponse.realtimeArrivalList;
    List<LineInfo> lines = [];
    Map<int, LineInfo> map = {};

    list?.forEach((arrival) {
      final lineId = arrival.subwayId;
      final stationId = arrival.statnId;
      if (stationId == null && lineId == null) {
        return;
      }
      final previousStationId = stationId! - 1;
      final nextStationId = stationId + 1;
      if (map[stationId] == null) {
        final lineInfo = LineInfo(
            id: lineId!,
            name: _lines[lineId],
            stationId: stationId!,
            stationName: _stations[stationId],
            leftStationName: _stations[previousStationId],
            rightStationName: _stations[nextStationId],
            color: lineColorMap[lineId],
            trains: []);
        map[stationId] = lineInfo;
        lines.add(lineInfo);
      }
      map[stationId]?.trains.add(Train.fromArrivalInfo(arrival));
    });

    lines.sort((a, b) => a.id.compareTo(b.id));

    return lines;
  }

  void _readCsvStationData() async {
    var list = await csvReader.readFile('assets/실시간도착_역정보_20230310.csv');
    for (var stationInfo in list) {
      final stationId = stationInfo[1];
      final stationName = stationInfo[2];
      final lineId = stationInfo[0];
      final lineName = stationInfo[3];
      stationNames.add(stationName);
      _stations[stationId] = stationName;
      _lines['$lineId'] = lineName;
    }
  }
}

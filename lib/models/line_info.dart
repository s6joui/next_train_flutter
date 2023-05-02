import 'dart:ui';
import 'package:next_train_flutter/models/train.dart';

class LineInfo {
  String id;
  String? name;
  int stationId;
  String? stationName;
  String? leftStationName;
  String? rightStationName;
  Color? color;
  List<Train> trains;

  LineInfo({
    required this.id,
    required this.name,
    required this.stationId,
    required this.stationName,
    required this.leftStationName,
    required this.rightStationName,
    required this.color,
    required this.trains,
  });

  String get lineId {
    return id.substring(0, 4);
  }

  String? get sanitizedName {
    return name?.replaceAll('호선', '');
  }

  List<Train> get rightHeadingTrains {
    return trains.where((train) => (train.direction ?? 0) > stationId).toList();
  }

  List<Train> get leftHeadingTrains {
    return trains.where((train) => (train.direction ?? 0) < stationId).toList();
  }

  bool get shouldDisplayRightHeadingTrain {
    if (rightHeadingTrains.isEmpty) {
      return false;
    }
    final train = rightHeadingTrains.first;
    if (train.currentLocation == stationName ||
        train.currentLocation == leftStationName) {
      return true;
    }
    return false;
  }

  double get rightHeadingTrainPosition {
    if (rightHeadingTrains.isEmpty) {
      return 0;
    }
    final train = rightHeadingTrains.first;
    if (train.currentLocation == stationName ||
        (train.remainingSeconds ?? 0) < 160) {
      return 1;
    } else if (train.currentLocation == leftStationName) {
      return 0.07;
    }
    return -0.5;
  }

  bool get shouldDisplayLeftHeadingTrain {
    if (leftHeadingTrains.isEmpty) {
      return false;
    }
    final train = leftHeadingTrains.first;
    if (train.currentLocation == stationName ||
        train.currentLocation == rightStationName) {
      return true;
    }
    return false;
  }

  double get leftHeadingTrainPosition {
    if (leftHeadingTrains.isEmpty) {
      return 0;
    }
    final train = leftHeadingTrains.first;
    if (train.currentLocation == stationName ||
        (train.remainingSeconds ?? 0) < 160) {
      return 1;
    } else if (train.currentLocation == rightStationName) {
      return 0.07;
    }
    return -0.5;
  }
}

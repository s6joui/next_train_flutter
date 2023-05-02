import 'package:intl/intl.dart';
import 'package:next_train_flutter/features/home/data/arrival_info.dart';

class Train {
  String? id;
  int? direction;
  int? remainingSeconds;
  String? message;
  String? currentLocation;

  int? get remainingMinutes {
    if (remainingSeconds == null || remainingSeconds == 0) {
      return null;
    }
    double minutes = remainingSeconds! / 60;
    return minutes.round();
  }

  String? get remainingStops {
    final numberString = message?.replaceAll(RegExp(r'[^0-9]'), '');
    if (numberString != null) {
      return numberString;
    }
    return null;
  }

  String get remainingTimeMessage {
    if (remainingMinutes != null) {
      return '$remainingMinutes분';
    }
    if (remainingStops != null && remainingStops!.isNotEmpty) {
      return '$remainingStops번째 전역';
    }
    return message ?? '-';
  }

  String get arrivalTime {
    final seconds = remainingSeconds!;
    final now = DateTime.now().add(Duration(seconds: seconds));
    return DateFormat('HH:mm').format(now);
  }

  Train(
      {required this.id,
      required this.direction,
      required this.remainingSeconds,
      required this.currentLocation});

  Train.fromArrivalInfo(ArrivalInfo info) {
    id = info.btrainNo;
    direction = info.statnTid;
    remainingSeconds = int.parse(info.barvlDt ?? '0');
    message = info.arvlMsg2;
    currentLocation = info.arvlMsg3;
  }
}

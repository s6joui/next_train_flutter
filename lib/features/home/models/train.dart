// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:next_train_flutter/features/home/data/arrival_info.dart';

class Train extends Equatable {
  final String? id;
  final int? direction;
  final int? remainingSeconds;
  final String? message;
  final String? currentLocation;

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

  const Train(
      {required this.id,
      required this.direction,
      required this.remainingSeconds,
      required this.message,
      required this.currentLocation});

  @override
  List<Object?> get props {
    return [
      id,
      direction,
      remainingSeconds,
      message,
      currentLocation,
    ];
  }

  factory Train.fromArrivalInfo(ArrivalInfo info) {
    return Train(
      id: info.btrainNo,
      direction: info.statnTid,
      remainingSeconds: int.parse(info.barvlDt ?? '0'),
      message: info.arvlMsg2,
      currentLocation: info.arvlMsg3,
    );
  }
}

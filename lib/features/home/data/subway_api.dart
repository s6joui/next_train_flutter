import 'package:next_train_flutter/api_key.dart';
import 'package:next_train_flutter/network/network_client.dart';
import 'package:next_train_flutter/features/home/data/arrival_info.dart';

abstract class SubwayApiRequest extends NetworkRequest {
  final String baseUrl =
      "http://swopenapi.seoul.go.kr/api/subway/$subwayApiKey/json/realtimeStationArrival/0/20/";
}

class ArrivalsRequest extends SubwayApiRequest {
  String stationName;

  ArrivalsRequest({required this.stationName});

  @override
  String get method => 'get';

  @override
  String get url => baseUrl + stationName;
}

class ArrivalsResponse {
  List<ArrivalInfo>? realtimeArrivalList;
  int? status;
  String? code;
  String? message;

  ArrivalsResponse(
      {this.realtimeArrivalList, this.status, this.code, this.message});

  factory ArrivalsResponse.fromJson(Map<String, dynamic> json) {
    return ArrivalsResponse(
        realtimeArrivalList: json['realtimeArrivalList']
            ?.map<ArrivalInfo>((data) => ArrivalInfo.fromJson(data))
            .toList(),
        status: json['status'],
        code: json['code'],
        message: json['message']);
  }
}

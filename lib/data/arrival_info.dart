class ArrivalInfo {
  String? subwayId;
  String? statnNm;
  String? trainLineNm;
  String? updnLine;
  String? barvlDt;
  String? bstatnNm;
  String? btrainNo;
  String? arvlMsg2;
  String? arvlMsg3;
  String? recptnDt;
  int? statnFid;
  int? statnTid;
  int? statnId;

  ArrivalInfo({
    required this.subwayId,
    required this.statnNm,
    required this.trainLineNm,
    required this.updnLine,
    required this.barvlDt,
    required this.bstatnNm,
    required this.btrainNo,
    required this.arvlMsg2,
    required this.arvlMsg3,
    required this.recptnDt,
    required this.statnFid,
    required this.statnTid,
    required this.statnId,
  });

  factory ArrivalInfo.fromJson(Map<String, dynamic> json) {
    return ArrivalInfo(
      subwayId: json['subwayId'],
      statnNm: json['statnNm'],
      trainLineNm: json['trainLineNm'],
      updnLine: json['updnLine'],
      barvlDt: json['barvlDt'],
      bstatnNm: json['bstatnNm'],
      btrainNo: json['btrainNo'],
      arvlMsg2: json['arvlMsg2'],
      arvlMsg3: json['arvlMsg3'],
      recptnDt: json['recptnDt'],
      statnFid: int.parse(json['statnFid']),
      statnTid: int.parse(json['statnTid']),
      statnId: int.parse(json['statnId']),
    );
  }
}

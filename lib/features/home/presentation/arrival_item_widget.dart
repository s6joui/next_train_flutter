import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_train_flutter/features/home/models/line_info.dart';
import 'package:next_train_flutter/features/home/models/train.dart';

class ArrivalItemWidget extends StatelessWidget {
  final LineInfo line;
  final ValueSetter<String?> onStationSelected;

  const ArrivalItemWidget(
      {super.key, required this.line, required this.onStationSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).cardColor,
              child: Column(children: [
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  StationNameWidget(
                      lineName: line.sanitizedName,
                      stationName: line.stationName,
                      color: line.color ?? Colors.white)
                ]),
                const SizedBox(height: 8),
                TrainTrackWidget(color: line.color ?? Colors.white),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ArrivalListWidget(
                            line: line, heading: TrainHeading.left),
                      ),
                      const SizedBox(width: 10),
                      Container(
                          color: Theme.of(context).highlightColor,
                          child: const SizedBox(width: 1, height: 50)),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ArrivalListWidget(
                            line: line, heading: TrainHeading.right),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 22,
              left: 20,
              child: GestureDetector(
                onTap: () => {onStationSelected(line.leftStationName)},
                child: Text(line.leftStationName ?? ''),
              ),
            ),
            Positioned(
              top: 22,
              right: 20,
              child: GestureDetector(
                onTap: () => {onStationSelected(line.rightStationName)},
                child: Text(line.rightStationName ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.chevron_left,
                      size: 16, color: Theme.of(context).hintColor),
                  Icon(CupertinoIcons.chevron_right,
                      size: 16, color: Theme.of(context).hintColor),
                ],
              ),
            ),
            Visibility(
                visible: line.shouldDisplayRightHeadingTrain,
                child: AnimatedPositioned(
                    top: 38,
                    left: line.rightHeadingTrainPosition *
                        ((MediaQuery.of(context).size.width / 2) - 27),
                    duration: const Duration(seconds: 120),
                    child: SizedBox(
                        width: 44,
                        height: 26,
                        child: Image.asset('assets/train_r.png')))),
            Visibility(
                visible: line.shouldDisplayLeftHeadingTrain,
                child: AnimatedPositioned(
                    top: 38,
                    right: line.leftHeadingTrainPosition *
                        ((MediaQuery.of(context).size.width / 2) - 27),
                    duration: const Duration(seconds: 120),
                    child: SizedBox(
                        width: 44,
                        height: 26,
                        child: Image.asset('assets/train_l.png')))),
          ],
        ));
  }
}

enum TrainHeading { left, right }

class ArrivalListWidget extends StatelessWidget {
  final LineInfo line;
  final TrainHeading heading;

  const ArrivalListWidget({Key? key, required this.line, required this.heading})
      : super(key: key);

  List<Train> get trains => heading == TrainHeading.left
      ? line.leftHeadingTrains
      : line.rightHeadingTrains;
  String? get direction => heading == TrainHeading.left
      ? line.leftStationName
      : line.rightStationName;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...trains.map((train) {
        return Row(
          children: [
            Expanded(
                flex: 1,
                child: Text('${train.arrivalTime} ${train.currentLocation}',
                    overflow: TextOverflow.fade, softWrap: false)),
            Text(train.remainingTimeMessage,
                style: TextStyle(color: line.color, shadows: const [
                  Shadow(
                      color: Colors.grey,
                      offset: Offset(0.4, 0.2),
                      blurRadius: 1)
                ]))
          ],
        );
      })
    ]);
  }
}

class TrainTrackWidget extends StatelessWidget {
  final Color color;

  const TrainTrackWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 8,
        color: color,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrainTrackStopWidget(color: color),
            TrainTrackStopWidget(size: 18, borderWidth: 4, color: color),
            TrainTrackStopWidget(color: color)
          ],
        ),
      )
    ]);
  }
}

class TrainTrackStopWidget extends StatelessWidget {
  final double size;
  final double borderWidth;
  final Color color;

  const TrainTrackStopWidget(
      {super.key, this.size = 14, this.borderWidth = 3, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: borderWidth, color: color)),
    );
  }
}

class StationNameWidget extends StatelessWidget {
  final String? lineName;
  final String? stationName;
  final Color color;

  const StationNameWidget(
      {super.key,
      required this.lineName,
      required this.stationName,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Text('${lineName?.substring(0, 1)}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        const SizedBox(width: 4),
        Text('$stationName', style: const TextStyle(fontSize: 16))
      ],
    );
  }
}

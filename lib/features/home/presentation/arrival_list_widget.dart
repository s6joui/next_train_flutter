// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:next_train_flutter/features/home/models/line_info.dart';
import 'package:next_train_flutter/features/home/presentation/arrival_item_widget.dart';

class ArrivalListWidget extends StatefulWidget {
  final List<LineInfo> data;

  const ArrivalListWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ArrivalListWidget> createState() => _ArrivalListWidgetState();
}

class _ArrivalListWidgetState extends State<ArrivalListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final lineInfo = widget.data[index];
        return ArrivalItemWidget(
            line: lineInfo, onStationSelected: (value) => {});
      },
      childCount: widget.data.length,
    ));
  }
}

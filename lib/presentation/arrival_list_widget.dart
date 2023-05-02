import 'package:flutter/material.dart';

class ArrivalListWidget extends StatefulWidget {
  const ArrivalListWidget({super.key});

  @override
  State<ArrivalListWidget> createState() => _ArrivalListWidgetState();
}

class _ArrivalListWidgetState extends State<ArrivalListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return const Placeholder();
      },
      childCount: 5,
    ));
  }
}

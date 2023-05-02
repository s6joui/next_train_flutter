import 'dart:math' as math;
import 'package:flutter/material.dart';

class SliverSeparatedListView extends StatelessWidget {
  final EdgeInsets padding;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const SliverSeparatedListView(
      {super.key, required this.padding, required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return itemBuilder(context, itemIndex);
            }
            return const Divider();
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, itemCount * 2 - 1),
        ),
      ),
    );
  }
}

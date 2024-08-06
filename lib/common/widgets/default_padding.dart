import 'package:flutter/material.dart';
import 'package:triller/app/core.dart';

class DefaultPadding extends StatelessWidget {
  const DefaultPadding({super.key, required this.child, this.bottom, this.top});

  final Widget child;
  final double? bottom;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppProperties.contentMargin,
        right: AppProperties.contentMargin,
        bottom: bottom ?? 0,
        top: top ?? 0,
      ),
      child: child,
    );
  }
}

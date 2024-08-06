import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class AgeSlider extends StatefulWidget {
  const AgeSlider({
    super.key,
    required this.initialWeight,
  });

  final int initialWeight;

  @override
  State<AgeSlider> createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  int weight = 2;

  @override
  void initState() {
    super.initState();
    //weight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
                  minValue: 1,
                  maxValue: 100,
                  value: weight,
                  onChanged: (val) => setState(() => weight = val),
                  width: constraints.maxWidth,
                  itemInRow: 7,
                );
        },
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.surface,
          ),
          child: SizedBox(
            height: 60,
            child: child,
          ),
        ),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: context.colorScheme.primary.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

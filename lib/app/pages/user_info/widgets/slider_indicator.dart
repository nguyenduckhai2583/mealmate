import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

import 'custom_slider.dart';

class SliderIndicator extends StatefulWidget {
  const SliderIndicator({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.min = 1,
    this.max = 100,
  });

  final int initialValue;
  final int min;
  final int max;
  final Function(int val) onChanged;

  @override
  State<SliderIndicator> createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<SliderIndicator> {
  int value = 2;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void _valueOnChanged(int val) {
    setState(() {
      value = val;
    });

    widget.onChanged(val);
  }

  @override
  Widget build(BuildContext context) {
    return WeightBackground(
      child: LayoutBuilder(builder: (context, constraints) {
        return CustomSlider(
          minValue: widget.min,
          maxValue: widget.max,
          value: value,
          onChanged: _valueOnChanged,
          width: constraints.maxWidth,
          itemInRow: 7,
        );
      }),
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
        Card(
          elevation: 4,
          child: SizedBox(height: 60, child: child),
        ),
        IgnorePointer(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

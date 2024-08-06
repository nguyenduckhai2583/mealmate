import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mealmate/core.dart';

class RulerPickerIndicator extends StatelessWidget {
  const RulerPickerIndicator({
    super.key,
    required this.value,
    required this.isMajor,
    this.axis = Axis.vertical,
  });

  final int value;
  final bool isMajor;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isMajor) _buildTextVertical(context, value),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildVerticalIndicator(context),
          ),
        ],
      );
    }

    return _buildHorizontal(context);
  }

  Widget _buildHorizontal(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isMajor) _buildTextHorizontal(context, value),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildHorizontalIndication(context),
        ),
      ],
    );
  }

  Widget _buildTextHorizontal(BuildContext context, int text) {
    return IntrinsicHeight(
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Text(
          "$text",
          maxLines: 1,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildTextVertical(BuildContext context, int text) {
    return IntrinsicWidth(
      child: OverflowBox(
        maxHeight: double.infinity,
        child: Text(
          "$text",
          maxLines: 1,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalIndication(BuildContext context) {
    Color color = context.colorScheme.onSurface.withOpacity(isMajor ? 1 : 0.3);
    double height = 25;
    if (isMajor) {
      height = 50;
    } else {
      if (value % 5 == 0) {
        height = 35;
      }
    }

    return SizedBox(
      height: height,
      width: isMajor ? 1.5 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
      ),
    );
  }

  Widget _buildVerticalIndicator(BuildContext context) {
    Color color = context.colorScheme.onSurface.withOpacity(isMajor ? 1 : 0.3);
    double width = 40;
    if (isMajor) {
      width = 70;
    } else {
      if (value % 5 == 0) {
        width = 55;
      }
    }

    return SizedBox(
      width: width,
      height: isMajor ? 2 : 1.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
      ),
    );
  }
}

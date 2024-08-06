import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mealmate/core.dart';

class WeightSlider extends StatelessWidget {
  WeightSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    required this.width,
    this.itemInRow = 5,
  }) : scrollController = ScrollController(
          initialScrollOffset: (value - minValue) * width / itemInRow,
        );

  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;
  final double width;
  final ScrollController scrollController;
  final int itemInRow;

  double get itemExtent => width / itemInRow;

  int _indexToValue(int index) => minValue + (index - _extraItemCount);

  int get _extraItemCount => itemInRow ~/ 2;

  int get _itemCount =>  (maxValue - minValue) + (_extraItemCount * 2 + 1);

  bool isExtra(int index) {
    return index < _extraItemCount || index >= _itemCount - _extraItemCount;
  }

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + (_extraItemCount * 2 + 1);
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);

          return isExtra(index)
              ? Container()
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 50),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      itemValue.toString(),
                      style: _getTextStyle(context, itemValue),
                    ),
                  ),
                );
        },
      ),
    );
  }

  TextStyle? _getDefaultTextStyle(BuildContext context) {
    return context.textTheme.titleLarge?.copyWith(
      color: context.colorScheme.onBackground,
      fontSize: 14,
    );
  }

  TextStyle? _getHighlightTextStyle(BuildContext context) {
    return context.textTheme.titleLarge?.copyWith(
      color: context.colorScheme.primary,
    );
  }

  TextStyle? _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle(context);
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) {
    return (offset + width / 2) ~/ itemExtent;
  }

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));

    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue);
      }
    }
    return true;
  }
}

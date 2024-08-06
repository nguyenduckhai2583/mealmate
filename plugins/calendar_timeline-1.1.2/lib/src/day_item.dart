import 'package:flutter/material.dart';

/// Creates a Widget representing the day.
class DayItem extends StatelessWidget {
  const DayItem({
    Key? key,
    required this.dayNumber,
    required this.shortName,
    required this.onTap,
    this.isSelected = false,
    this.dayColor,
    this.activeDayColor,
    this.activeDayBackgroundColor,
    this.available = true,
    this.dotsColor,
    this.dayNameColor,
    this.shrink = false,
  }) : super(key: key);
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final Function onTap;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeDayBackgroundColor;
  final bool available;
  final Color? dotsColor;
  final Color? dayNameColor;
  final bool shrink;

  Color? _dayColor(BuildContext context) {
    return isSelected
        ? activeDayColor
        : available
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.outline.withOpacity(0.5);
  }

  Widget _selectedWrap(BuildContext context, {required Widget child}) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }

  Widget _buildDay(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          dayNumber.toString(),
          style: TextStyle(
              fontSize: 24,
              color: _dayColor(context),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400),
        ),
        Text(
          shortName.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: _dayColor(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: available ? onTap as void Function()? : null,
      child: SizedBox(
        width: 70,
        child: isSelected
            ? _selectedWrap(context, child: _buildDay(context))
            : _buildDay(context),
      ),
    );
  }
}

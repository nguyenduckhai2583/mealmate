import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate/core.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget({
    super.key,
    required this.calories,
    this.textColor,
    this.background,
  });

  final int calories;
  final Color? textColor;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background ?? context.primaryColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAsset.icProtein,
              colorFilter: ColorFilter.mode(
                textColor ?? context.colorScheme.onInverseSurface,
                BlendMode.srcIn,
              ),
            ),
            Space.horizontal(),
            Text(
              "${calories.toInt()} ${context.localization.calories}",
              style: TextStyle(
                color: textColor ?? context.colorScheme.onInverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

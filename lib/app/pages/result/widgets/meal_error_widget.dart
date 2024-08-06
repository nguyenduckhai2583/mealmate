import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate/core.dart';

class MealErrorWidget extends StatelessWidget {
  const MealErrorWidget({super.key, this.paddingTop});

  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop != null ? (paddingTop! / 2) : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAsset.error,
            fit: BoxFit.contain,
            width: context.width,
            height: context.width / 2,
          ),
          RichText(
            text: TextSpan(
              text: context.localization.oops,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "\n${context.localization.somethingWrong}",
                  style: context.textTheme.titleMedium?.copyWith(),
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate/core.dart';

class NutritionItemWidget extends StatelessWidget {
  const NutritionItemWidget({super.key, required this.nutrition});

  final NutritionResponse nutrition;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          nutrition.getName(),
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Space(value: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                context.localization.nutritionValue,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ),
            Text(
              nutrition.getCalories(),
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            )
          ],
        ),
        const Space(value: 16),
        _buildNutritionValues(
          context,
          title: context.localization.protein,
          value: nutrition.getProteinDisplay(),
          iconPath: AppAsset.icProtein,
        ),
        const Space(value: 16),
        _buildNutritionValues(
          context,
          title: context.localization.carbohydrates,
          value: nutrition.getCarbohydrates(),
          iconPath: AppAsset.icCarbs,
        ),
        const Space(value: 16),
        _buildNutritionValues(
          context,
          title: context.localization.fat,
          value: nutrition.getFat(),
          iconPath: AppAsset.icFat,
        ),
      ],
    );
  }

  Widget _buildNutritionValues(
    BuildContext context, {
    required String title,
    required String value,
    required String iconPath,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                context.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Space.horizontal(value: 12),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.outline,
            ),
          )
        ],
      ),
    );
  }
}

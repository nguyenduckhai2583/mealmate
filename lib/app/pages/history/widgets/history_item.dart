import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.result, this.resultOnClicked});
  final ResultResponse result;
  final Function(ResultResponse result)? resultOnClicked;

  @override
  Widget build(BuildContext context) {
    Color? borderColor =
        result.dish?.firstOrNull?.getResultType().getColor(context);
    int? calories = result.dish?.firstOrNull?.getCalories();

    String? filePath = result.getFilePath();
    String? dishName = result.getDishName();

    return InkWell(
      onTap: () => resultOnClicked?.call(result),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? context.colorScheme.primaryContainer,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filePath != null) ...[
                  _buildImage(context, filePath),
                  Space.horizontal(value: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (dishName != null) ...[
                        Text(
                          dishName,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Space(value: 4),
                      ],
                      if (calories != null) CaloriesWidget(calories: calories),
                    ],
                  ),
                )
              ],
            ),
            const Space(),
            _buildDescription(context)
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String filePath) {
    String? heroTag = result.dish?.firstOrNull?.id;

    return Container(
      width: context.width / 4,
      height: context.width / 4,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: CustomHero(
        tag: heroTag,
        subTag: "image",
        child: Image.file(
          File(filePath),
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported_outlined, size: 64);
          },
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      children: [
        Text(
          result.getExplain(),
          style: context.textTheme.titleSmall,
          maxLines: 3,
        )
      ],
    );
  }
}

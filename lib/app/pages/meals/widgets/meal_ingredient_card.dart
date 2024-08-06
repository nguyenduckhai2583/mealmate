import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class MealIngredientCard extends StatelessWidget {
  const MealIngredientCard({
    super.key,
    required this.onTap,
    required this.globalKey,
  });

  final GlobalKey globalKey;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.width * .5,
      child: Stack(
        children: [
          Card(
            child: Container(
              width: context.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.width * .65,
                      ),
                      child: AutoSizeText(
                        context.localization.ingredientAlready,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.width * .65,
                      ),
                      child: AutoSizeText(
                        context.localization.weSuggestMealFromIngredient,
                        style: context.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FilledButton.icon(
                        key: globalKey,
                        onPressed: onTap,
                        icon: Text(context.localization.checkItNow),
                        label: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          shape: const StadiumBorder(),
                          elevation: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: const Offset(30, -30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.width * .35,
                  maxWidth: context.width * .35,
                ),
                child: Image.asset(
                  AppAsset.food,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

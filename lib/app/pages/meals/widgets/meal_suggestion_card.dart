import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class MealSuggestionCard extends StatelessWidget {
  const MealSuggestionCard({
    super.key,
    required this.globalKey,
    required this.onTap,
  });

  final GlobalKey globalKey;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: context.width,
        height: context.width * .5,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width * .4,
                  maxHeight: context.width * .4,
                ),
                child: Image.asset(AppAsset.food1, fit: BoxFit.fitHeight),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              bottom: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      context.localization.mealSuggestion,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.width * 0.5,
                      ),
                      child: AutoSizeText(
                        context.localization.weWillPreparedForYou,
                        style: context.textTheme.bodyMedium,
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
                        label: const Icon(Icons.keyboard_arrow_down, size: 20),
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
          ],
        ),
      ),
    );
  }
}

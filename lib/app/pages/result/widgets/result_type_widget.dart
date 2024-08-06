import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class ResultTypeWidget extends StatelessWidget {
  const ResultTypeWidget({super.key, required this.resultType});

  final ResultType resultType;

  @override
  Widget build(BuildContext context) {
    Color? labelColor = resultType.getTextColor(context);
    IconData icon = resultType.getIcon();

    return Card(
      color: context.colorScheme.background,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: labelColor),
            Space.horizontal(),
            Text(
              resultType.getTitle(context).toUpperCase(),
              style: TextStyle(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}

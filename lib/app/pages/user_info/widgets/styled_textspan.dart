import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:styled_text/styled_text.dart';

class StyledTextSpan extends StatelessWidget {
  const StyledTextSpan({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      style: context.textTheme.headlineMedium,
      tags: {
        'primary': StyledTextTag(
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        ),
        'green': StyledTextTag(
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.secondaryContainer,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        )
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    required this.onChanged,
    this.focusColor,
  });

  final TextEditingController controller;
  final Function(String onChanged) onChanged;
  final Color? focusColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: focusColor != null
            ? OutlineInputBorder(
                borderSide: BorderSide(color: focusColor!),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        contentPadding: const EdgeInsets.all(12),
        fillColor: context.colorScheme.surfaceVariant.withOpacity(0.5),
        hintText: context.localization.enterYourGoal,
        counterText: "",
      ),
      onChanged: onChanged,
      minLines: 3,
      maxLines: 10,
      maxLength: 100,
    );
  }
}

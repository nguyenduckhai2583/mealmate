import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
    this.enable = true,
    this.color,
    this.iconData = Icons.arrow_forward,
    required this.onClick,
    this.tag,
  });

  final bool enable;
  final Function() onClick;
  final Color? color;
  final IconData? iconData;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: enable ? onClick : null,
      backgroundColor: enable
          ? color ?? context.colorScheme.primaryContainer
          : context.colorScheme.surfaceVariant,
      heroTag: tag,
      child: Icon(iconData),
    );
  }
}

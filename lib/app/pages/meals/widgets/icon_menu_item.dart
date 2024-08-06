import 'package:flutter/material.dart';

class IconMenuItem extends StatelessWidget {
  const IconMenuItem({super.key, required this.iconData, required this.title});

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, size: 20),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}

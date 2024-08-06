import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  const CustomHero({super.key, required this.child, this.tag, this.subTag});

  final Widget child;
  final String? tag;
  final String? subTag;

  @override
  Widget build(BuildContext context) {
    if (tag case String tag) {
      return Hero(tag: "$tag$subTag", child: child);
    }

    return child;
  }
}

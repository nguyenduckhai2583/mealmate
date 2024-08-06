import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NutritionResultView extends GetView<NutritionResultController> {
  const NutritionResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localization.nutrition)),
      body: SafeArea(
        child: DefaultPadding(
          child: Column(
            children: [
              _buildImage(context),
              const Space(value: 24),
              Expanded(child: _buildMealNutrition(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (controller.filePath == null) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: context.width,
        maxHeight: context.width,
      ),
      child: Image.file(
        File(controller.filePath!),
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image_outlined, size: 64);
        },
      ),
    );
  }

  Widget _buildMealNutrition(BuildContext context) {
    return Obx(() {
      /// Loading
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      /// Empty or Error
      if (controller.nutritions.isEmpty) {
        return const MealErrorWidget();
      }

      var count = controller.nutritions.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (controller.pageController != null && count > 1) ...[
            SmoothPageIndicator(
              controller: controller.pageController!,
              count: count,
              effect: WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                paintStyle: PaintingStyle.fill,
                activeDotColor: context.primaryColor,
              ),
            ),
            const Space(value: 16),
          ],
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              children: controller.nutritions
                  .map((e) => NutritionItemWidget(nutrition: e))
                  .toList(),
            ),
          ),
        ],
      );
    });
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mealmate/core.dart';
import 'package:collection/collection.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  void _eatThisFood({Dish? dish}) {
    controller.eatThisFood(dish: dish);
  }

  @override
  Widget build(BuildContext context) {
    String title = controller.mealType?.getTitle(context) ?? "";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 8),
        child: DefaultPadding(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(context),
            _buildResult(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (controller.filePath == null) {
      return const SizedBox.shrink();
    }

    String? heroTag = controller.responseRx?.dish?.firstOrNull?.id;
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.width,
        maxHeight: context.width,
      ),
      child: CustomHero(
        tag: heroTag,
        subTag: "image",
        child: Image.file(
          File(controller.filePath!),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_outlined, size: 64);
          },
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    return Obx(() {
      double top;
      if (controller.filePath == null) {
        top =
            context.height / 2 - kToolbarHeight - context.mediaQueryPadding.top;
      } else {
        top = (context.height - context.width) / 2;
      }

      /// Loading
      if (controller.loading.value) {
        return Padding(
          padding: EdgeInsets.only(top: top),
          child: const CircularProgressIndicator(),
        );
      }

      /// Empty or Error
      if (controller.responseRx == null) {
        return MealErrorWidget(paddingTop: top / 2);
      }

      List<Dish>? dishes = controller.responseRx?.getDishes();
      String? explain = controller.responseRx?.getExplain();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dishes != null && dishes.isNotEmpty) ...[
            const Space(value: 16),
            _buildDishIngredientsSuggestion(context, dishes),
          ],
          if (explain != null) ...[
            const Space(value: 16),
            Text(
              context.localization.explanation,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Space(),
            MarkdownBody(
              data: explain,
              styleSheet: MarkdownStyleSheet.fromTheme(
                ThemeData(
                  textTheme: TextTheme(
                    bodyMedium: context.textTheme.bodyLarge?.copyWith(
                      height: 1.75,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      );
    });
  }

  Widget _buildDishIngredientsSuggestion(
    BuildContext context,
    List<Dish> dishes,
  ) {
    Iterable<Widget> dishesWidget = [];
    dishesWidget = dishes.mapIndexed(
      (index, value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DishWidget(
          dish: value,
          expandByDefault: index == 0,
          onEatThisDish: (dish) => _eatThisFood(dish: dish),
        ),
      ),
    );
    return Column(children: dishesWidget.toList());
  }
}

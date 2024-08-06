import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class MealsView extends GetView<MealsController> {
  const MealsView({super.key});

  void _showMenu(
    BuildContext context, {
    required GlobalKey key,
    required MealType mealType,
  }) {
    var currentCtx = key.currentContext;
    var renderBox = currentCtx?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    var pos = renderBox.localToGlobal(Offset.zero);
    var right = context.width - pos.dx - renderBox.size.width;
    var top = pos.dy + renderBox.size.height;

    var menuItems = <PopupMenuEntry>[];
    if (mealType.hasPhoto()) {
      menuItems = [
        PopupMenuItem(
          onTap: () => _takePhotoOnClicked(context, mealType: mealType),
          child: IconMenuItem(
            iconData: Icons.camera_alt_outlined,
            title: context.localization.camera,
          ),
        ),
        PopupMenuItem(
          onTap: () => _selectPhotoOnClicked(context, mealType: mealType),
          child: IconMenuItem(
            iconData: Icons.photo_outlined,
            title: context.localization.gallery,
          ),
        ),
      ];
    } else {
      for (var item in MealTime.values) {
        menuItems.add(
          PopupMenuItem(
            onTap: () {
              var input = ResultInput(mealType: mealType, mealTime: item);
              _resultPageOnClicked(input);
            },
            child: IconMenuItem(
              iconData: item.getIcon(),
              title: item.getTitle(context),
            ),
          ),
        );
      }
    }

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(pos.dx + 4, top, right + 4, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: menuItems,
    );
  }

  Future<void> _takePhotoOnClicked(
    BuildContext context, {
    required MealType mealType,
  }) async {
    var file = await MediaPickerManager.takePhoto(context);
    if (file != null) {
      _resultPageOnClicked(
        ResultInput(filePath: file.path, mealType: mealType),
      );
    }
  }

  Future<void> _selectPhotoOnClicked(
    BuildContext context, {
    required MealType mealType,
  }) async {
    var file = await MediaPickerManager.selectPhoto(context);
    if (file != null) {
      _resultPageOnClicked(
        ResultInput(filePath: file.path, mealType: mealType),
      );
    }
  }

  void _resultPageOnClicked(ResultInput input) {
    Get.toNamed(Routes.result, arguments: input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: DefaultPadding(
          child: Column(
            children: [
              _buildMealMatch(context),
              const Space(value: 36),
              MealSuggestionCard(
                globalKey: controller.mealSuggestionKey,
                onTap: () => _showMenu(
                  context,
                  key: controller.mealSuggestionKey,
                  mealType: MealType.mealSuggestion,
                ),
              ),
              const Space(value: 40),
              MealIngredientCard(
                globalKey: controller.mealIngredientKey,
                onTap: () => _showMenu(
                  context,
                  key: controller.mealIngredientKey,
                  mealType: MealType.mealIngredient,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealMatch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.mealMatch,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Space(),
        Row(
          children: [
            Expanded(
              child: Text(
                context.localization.mealMatchDescription,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ),
            Space.horizontal(),
            FilledButton.icon(
              key: controller.mealMatchKey,
              onPressed: () {
                _showMenu(
                  context,
                  key: controller.mealMatchKey,
                  mealType: MealType.mealMatch,
                );
              },
              icon: Text(context.localization.checkItNow),
              label: const Icon(Icons.keyboard_arrow_down, size: 20),
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.comfortable,
                shape: const StadiumBorder(),
                elevation: 4,
              ),
            )
          ],
        )
      ],
    );
  }
}

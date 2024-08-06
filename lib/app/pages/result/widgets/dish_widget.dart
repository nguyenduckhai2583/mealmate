import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class DishWidget extends StatefulWidget {
  const DishWidget({
    super.key,
    required this.dish,
    this.onEatThisDish,
    this.expandByDefault = false,
  });

  final Dish dish;
  final bool expandByDefault;
  final Function(Dish dish)? onEatThisDish;

  @override
  State<DishWidget> createState() => _DishWidgetState();
}

class _DishWidgetState extends State<DishWidget> {
  bool expand = false;

  @override
  void initState() {
    expand = widget.expandByDefault;
    super.initState();
  }

  void toggleExpand() {
    setState(() {
      expand = !expand;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? dishName = widget.dish.getDishName();
    Color? labelColor = widget.dish.getResultType().getColor(context);

    return Card(
      color: labelColor,
      child: InkWell(
        onTap: toggleExpand,
        child: Container(
          width: context.width,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dishName != null) _buildDishNameHeader(context, dishName),
              _buildDishAnimatedInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animated({required Widget child}) {
    return AnimatedSize(
      duration: AppProperties.defaultTransitionDuration,
      alignment: Alignment.bottomLeft,
      child: expand ? child : const SizedBox(),
    );
  }

  Widget _buildDishAnimatedInfo(BuildContext context) {
    String? disInstruction = widget.dish.getDishInstruction();
    List<String>? dishIngredients = widget.dish.getDishIngredients();
    bool alreadyAte = widget.dish.alreadyAte;

    return _animated(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space(),
          _buildTag(context),
          if (dishIngredients != null && dishIngredients.isNotEmpty)
            _buildIngredients(dishIngredients),
          if (disInstruction != null && disInstruction.isNotEmpty)
            _buildInstruction(disInstruction),
          if (!alreadyAte) _buildEatButton(context)
        ],
      ),
    );
  }

  Widget _buildDishNameHeader(BuildContext context, String dishName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            dishName,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AnimatedRotation(
          turns: expand ? -1 / 2 : 0,
          duration: AppProperties.defaultTransitionDuration,
          child: const Icon(Icons.keyboard_arrow_down),
        )
      ],
    );
  }

  Widget _buildTag(BuildContext context) {
    int? calories = widget.dish.getCalories();
    ResultType resultType = widget.dish.getResultType();

    return Wrap(
      children: [
        ResultTypeWidget(resultType: resultType),
        if (calories != null)
          CaloriesWidget(
            calories: calories,
            textColor: context.primaryColor,
            background: context.colorScheme.background,
          ),
      ],
    );
  }

  Widget _buildIngredients(List<String> dishIngredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Space(),
        Text(
          context.localization.ingredients,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Space(value: 4),
        ...dishIngredients.map(
          (item) => Text(
            "* $item",
            style: context.textTheme.titleSmall,
          ),
        ),
        const Space(),
      ],
    );
  }

  Widget _buildInstruction(String dishInstruction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.instruction,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Space(value: 4),
        Text(
          dishInstruction,
          style: context.textTheme.titleSmall,
        )
      ],
    );
  }

  Widget _buildEatButton(BuildContext context) {
    String text = widget.dish.getResultType().getButtonText(context);
    Color? labelColor = widget.dish.getResultType().getTextColor(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: () => widget.onEatThisDish?.call(widget.dish),
        style: FilledButton.styleFrom(
          fixedSize: Size.fromWidth(context.width),
        ),
        child: Text(text, style: TextStyle(color: labelColor)),
      ),
    );
  }
}

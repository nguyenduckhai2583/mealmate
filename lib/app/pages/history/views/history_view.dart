import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  Future<void> _selectDateOnClicked(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      currentDate: controller.selectedDate,
      initialDate: controller.selectedDate,
      selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
    );

    controller.selectedDateOnChanged(date);
  }

  void _historyOnClicked(ResultResponse result) {
    Get.toNamed(Routes.result, arguments: ResultInput(result: result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.history),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => _selectDateOnClicked(context),
            icon: const Icon(Icons.calendar_month),
          )
        ],
      ),
      body: DefaultPadding(
        child: Column(
          children: [
            _buildCalendar(context),
            const Space(value: 12),
            _buildSummary(context),
            const Space(),
            Expanded(child: _buildHistory(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Obx(() {
      if (controller.results.isEmpty) return const SizedBox.shrink();

      int totalMeal = controller.results.length;
      int totalCalories = controller.results.fold(0, (previousValue, element) {
        var calo = element.dish?.firstOrNull?.getCalories();
        if (calo != null) {
          return previousValue + calo;
        }

        return previousValue;
      });

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Meals: $totalMeal",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Total calories: $totalCalories",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    });
  }

  Widget _buildHistory(BuildContext context) {
    return Obx(() {
      if (controller.results.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.icEmpty, width: 84, height: 84),
            const Space(),
            Text(
              context.localization.thereNoThingHere,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.outline,
              ),
            )
          ],
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 8),
        itemCount: controller.results.length,
        separatorBuilder: (_, __) => const Space(value: 16),
        itemBuilder: (context, index) {
          var result = controller.results[index];
          return HistoryItem(
            result: result,
            resultOnClicked: _historyOnClicked,
          );
        },
      );
    });
  }

  Widget _buildCalendar(BuildContext context) {
    return Obx(() {
      return CalendarTimeline(
        initialDate: controller.selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
        onDateSelected: controller.selectedDateOnChanged,
        monthColor: context.colorScheme.outline,
        dayColor: context.colorScheme.onSecondaryContainer,
        activeDayColor: context.colorScheme.onTertiary,
        activeBackgroundDayColor: context.primaryColor,
        leftMargin: (context.width - AppProperties.contentMargin * 2) / 5,
      );
    });
  }
}

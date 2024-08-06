import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class GoalView extends StatefulWidget {
  const GoalView({super.key});

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> with HiveMixin, StorageMixin {
  TextEditingController goalInputController = TextEditingController();
  String goalText = "";

  UserInfo? userInfo;
  bool showInput = false;
  List<Goal> selectedGoals = [];
  List<Goal> goalSuggestions = [];

  bool navigateBack = false;

  @override
  void initState() {
    _initRoute();
    goalSuggestions = Goal.values;
    _initGoal();
    super.initState();
  }

  void _initRoute() {
    if (Get.arguments != null && Get.arguments is UserInfoInput) {
      navigateBack = (Get.arguments as UserInfoInput).navigateBack;
    }
  }

  Future<void> _initGoal() async {
    userInfo = await getUserInfo();
    userInfo?.getGoalChoices().ifNotNull((it) {
      setState(() {
        selectedGoals.addAll(it);
      });
    });

    userInfo?.getGoalText().ifNotNull((it) {
      setState(() {
        showInput = it.isNotEmpty;
        goalText = it;
      });
      goalInputController.text = it;
    });
  }

  void _goalPick(Goal goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }

    setState(() {});
  }

  void _showInput() {
    setState(() {
      showInput = true;
    });
  }

  void _nextOnClicked() {
    userInfo?.setGoalText(goalText.trim());
    userInfo?.setGoalChoices(selectedGoals);
    saveUser(userInfo);

    if (navigateBack) {
      Get.back();
    } else {
      box.setData(AppKeys.alreadyInitUserInfo, true);
      Get.offAllNamed(Routes.home);
    }
  }

  bool get allowNext => selectedGoals.isNotEmpty || goalText.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      floatingActionButton: Fab(enable: allowNext, onClick: _nextOnClicked),
      body: SingleChildScrollView(
        child: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledTextSpan(text: context.localization.whatYourGoal),
              const Space(value: 12),
              _buildChipsSuggestion(),
              _notFoundText(),
              const Space(),
              _buildGoal(),
              const Space(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoal() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.ease,
      switchOutCurve: Curves.ease,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -0.5),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
      child: showInput ? _buildInput() : const SizedBox(),
    );
  }

  Widget _buildInput() {
    return TextFieldInput(
      controller: goalInputController,
      onChanged: (val) {
        setState(() {
          goalText = val;
        });
      },
    );
  }

  Widget _notFoundText() {
    return TextButton(
      onPressed: _showInput,
      style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
      child: Text(context.localization.notFound),
    );
  }

  Widget _buildChipsSuggestion() {
    return Wrap(
      spacing: 8.0,
      alignment: WrapAlignment.start,
      children: List<Widget>.generate(
        goalSuggestions.length,
        (int index) {
          var item = goalSuggestions[index];

          return ChoiceChip(
            selectedColor: context.colorScheme.primaryContainer,
            label: Text(item.getTitle(context)),
            showCheckmark: false,
            selected: selectedGoals.contains(item),
            onSelected: (bool selected) {
              _goalPick(item);
            },
          );
        },
      ).toList(),
    );
  }
}

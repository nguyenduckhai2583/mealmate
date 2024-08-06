import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class MedicalConditionView extends StatefulWidget {
  const MedicalConditionView({super.key});

  @override
  State<MedicalConditionView> createState() => _MedicalConditionViewState();
}

class _MedicalConditionViewState extends State<MedicalConditionView>
    with HiveMixin {
  TextEditingController mcInputController = TextEditingController();
  String mcText = "";

  UserInfo? userInfo;
  bool showInput = false;
  List<MedicalCondition> selectedMc = [];
  List<MedicalCondition> mcSuggestions = [];

  bool navigateBack = false;

  @override
  void initState() {
    _initRoute();
    mcSuggestions = MedicalCondition.values;
    _initMedicalCondition();
    super.initState();
  }

  void _initRoute() {
    if (Get.arguments != null && Get.arguments is UserInfoInput) {
      navigateBack = (Get.arguments as UserInfoInput).navigateBack;
    }
  }

  Future<void> _initMedicalCondition() async {
    userInfo = await getUserInfo();
    userInfo?.getMCChoices().ifNotNull((it) {
      setState(() {
        selectedMc.addAll(it);
      });
    });

    userInfo?.getMCText().ifNotNull((it) {
      setState(() {
        showInput = it.isNotEmpty;
        mcText = it;
      });
      mcInputController.text = it;
    });
  }

  void _mcPick(MedicalCondition mc) {
    if (selectedMc.contains(mc)) {
      selectedMc.remove(mc);
    } else {
      selectedMc.add(mc);
    }

    setState(() {});
  }

  void _showInput() {
    setState(() {
      showInput = true;
    });
  }

  void _nextOnClicked() {
    userInfo?.setMCChoices(selectedMc);
    userInfo?.setMCText(mcText.trim());
    saveUser(userInfo);

    if (navigateBack) {
      Get.back();
    } else {
      Get.toNamed(Routes.goal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      floatingActionButton: Fab(
        color: context.colorScheme.secondaryContainer,
        onClick: _nextOnClicked,
      ),
      body: SingleChildScrollView(
        child: DefaultPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledTextSpan(
                text: context.localization.doYouHaveAnyMedicalCondition,
              ),
              const Space(value: 12),
              _buildChipsSuggestion(),
              _notFoundText(),
              const Space(),
              _buildMCInput(),
              const Space(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMCInput() {
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
      controller: mcInputController,
      focusColor: context.colorScheme.secondary,
      onChanged: (val) {
        setState(() {
          mcText = val;
        });
      },
    );
  }

  Widget _notFoundText() {
    return TextButton(
      onPressed: _showInput,
      style: TextButton.styleFrom(
        visualDensity: VisualDensity.compact,
        foregroundColor: context.colorScheme.tertiary,
      ),
      child: Text(context.localization.notFound),
    );
  }

  Widget _buildChipsSuggestion() {
    return Wrap(
      spacing: 8.0,
      alignment: WrapAlignment.start,
      children: List<Widget>.generate(
        mcSuggestions.length,
        (int index) {
          var item = mcSuggestions[index];

          return ChoiceChip(
            label: Text(item.getTitle(context)),
            showCheckmark: false,
            selected: selectedMc.contains(item),
            onSelected: (bool selected) {
              _mcPick(item);
            },
          );
        },
      ).toList(),
    );
  }
}

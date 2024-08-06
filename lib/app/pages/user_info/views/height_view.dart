import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

const _initialHeight = 150;

class HeightPickerView extends StatefulWidget {
  const HeightPickerView({super.key});

  @override
  State<HeightPickerView> createState() => _HeightPickerViewState();
}

class _HeightPickerViewState extends State<HeightPickerView> with HiveMixin {
  late RulerScalePickerController<int> rulerController;

  UserInfo? userInfo;
  int currentVal = _initialHeight;

  @override
  void initState() {
    rulerController = NumericRulerScalePickerController(
      firstValue: 20,
      initialValue: currentVal,
      lastValue: 300,
      interval: 1,
    );
    rulerController.addListener(_listenValueChange);
    _initHeight();
    super.initState();
  }

  @override
  void dispose() {
    rulerController.removeListener(_listenValueChange);
    super.dispose();
  }

  void _initHeight() async {
    userInfo = await getUserInfo();
    userInfo?.getHeight()?.ifNotNull((it) {
      setState(() {
        currentVal = it;
      });
      rulerController.setValue(currentVal);
    });
  }

  void _listenValueChange() {
    setState(() {
      currentVal = rulerController.value;
    });
  }

  void _nextOnClicked() {
    userInfo?.setHeight(currentVal);
    saveUser(userInfo);

    Get.toNamed(Routes.medicalCondition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      floatingActionButton: Fab(onClick: _nextOnClicked),
      body: DefaultPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledTextSpan(text: context.localization.howTallAreYou),
            const Space(),
            Expanded(child: Center(child: _buildHeightPicker())),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              text: '$currentVal',
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: 64
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'cm',
                  style: context.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: _buildRuler(),
        ),
      ],
    );
  }

  Widget _buildRuler() {
    return NumericRulerScalePicker(
      controller: rulerController,
      scaleIndicatorBuilder: (
        _,
        __,
        int value, {
        required bool isMajorIndicator,
      }) {
        return RulerPickerIndicator(
          value: value,
          isMajor: isMajorIndicator,
        );
      },
      scaleMarkerBuilder: (context, axis) {
        return CustomPaint(
          size: const Size(20, 20),
          painter: TrianglePainter(
            color: context.primaryColor,
            paintingStyle: PaintingStyle.fill,
          ),
        );
      },
      options: const RulerScalePickerOptions(
        orientation: Axis.vertical,
        showControls: false,
      ),
    );
  }
}

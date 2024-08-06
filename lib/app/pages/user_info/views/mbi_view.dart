import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class WeightAgeView extends StatefulWidget {
  const WeightAgeView({super.key});

  @override
  State<WeightAgeView> createState() => _WeightAgeViewState();
}

class _WeightAgeViewState extends State<WeightAgeView> with HiveMixin {
  int weight = 70;
  int age = 20;
  Gender? gender;

  UserInfo? userInfo;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    userInfo = await getUserInfo();
    _initGender();
    _initWeight();
  }

  void _initGender() {
    setState(() {
      gender = userInfo?.getGender();
    });
  }

  void _initWeight() {
    userInfo?.getWeight().ifNotNull((it) {
      setState(() {
        weight = it;
      });
    });
  }

  void initAge() {
    userInfo?.getAge().ifNotNull((it) {
      setState(() {
        age = it;
      });
    });
  }

  void _setGender(Gender gd) {
    setState(() {
      gender = gd;
    });
  }

  void _weightOnChanged(int val) {
    setState(() {
      weight = val;
    });
  }

  void _nextOnClicked() {
    userInfo?.setGender(gender);
    userInfo?.setWeight(weight);
    userInfo?.setAge(age);
    saveUser(userInfo);

    Get.toNamed(Routes.height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      floatingActionButton: Fab(
        enable: gender != null,
        onClick: _nextOnClicked,
      ),
      body: DefaultPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledTextSpan(text: context.localization.whatYouLookLike),
            const Space(value: 24),
            Text(
              context.localization.gender,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
            const Space(),
            _buildGenderPicker(),
            const Space(value: 32),
            Row(
              children: [
                Text(
                  context.localization.weight,
                  style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600
                  ),
                ),
                const Spacer(),
                Text(
                  "kilogram",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline
                  ),
                ),
              ],
            ),
            const Space(),
            const AgeSlider(initialWeight: 70),
            const Space(value: 32),
            Text(
              context.localization.age,
              style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600
              ),
            ),
            const Space(),
            const AgeSlider(initialWeight: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex: 3, child: _buildGenderItem(Gender.male)),
        Space.horizontal(value: 16),
        Expanded(flex: 3, child: _buildGenderItem(Gender.female)),
        Space.horizontal(value: 16),
        const Expanded(flex: 3, child: SizedBox()),
      ],
    );
  }

  Widget _buildGenderItem(Gender gd) {
    Color color =
        gender == gd ? context.primaryColor : context.colorScheme.outline;

    return InkWell(
      onTap: () => _setGender(gd),
      splashFactory: NoSplash.splashFactory,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(gd.getIcon(), size: 64, color: color),
            const Space(value: 16),
            Text(
              gd.getTitle(context),
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

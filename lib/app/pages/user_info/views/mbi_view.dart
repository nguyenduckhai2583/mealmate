import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class MBIView extends StatefulWidget {
  const MBIView({super.key});

  @override
  State<MBIView> createState() => _MBIViewState();
}

class _MBIViewState extends State<MBIView> with HiveMixin {
  int weight = 70;
  int age = 20;
  Gender? gender;
  UserInfo? userInfo;

  bool navigateBack = false;
  bool loading = true;

  @override
  void initState() {
    _initRoute();
    _initData();
    super.initState();
  }

  void _initRoute() {
    if (Get.arguments != null && Get.arguments is UserInfoInput) {
      navigateBack = (Get.arguments as UserInfoInput).navigateBack;
    }
  }

  Future<void> _initData() async {
    userInfo = await getUserInfo();
    gender = userInfo?.getGender();
    userInfo?.getWeight().ifNotNull((it) {
      weight = it;
    });
    userInfo?.getAge().ifNotNull((it) {
      age = it;
    });

    loading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
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

  void _ageOnChanged(int val) {
    setState(() {
      age = val;
    });
  }

  void _nextOnClicked() {
    userInfo?.setGender(gender);
    userInfo?.setWeight(weight);
    userInfo?.setAge(age);
    saveUser(userInfo);

    if (navigateBack) {
      Get.back();
    } else {
      Get.toNamed(Routes.height);
    }
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
                fontWeight: FontWeight.w600,
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  "kilogram",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
            const Space(),
            if (!loading)
              SliderIndicator(
                key: const ValueKey("weight-slider"),
                initialValue: weight,
                onChanged: _weightOnChanged,
                max: 200,
              ),
            const Space(value: 32),
            Text(
              context.localization.age,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Space(),
            if (!loading)
              SliderIndicator(
                key: const ValueKey("age-slider"),
                initialValue: age,
                onChanged: _ageOnChanged,
                max: 120,
              ),
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
    FontWeight fw;
    Color color;

    if (gender == gd) {
      color = context.primaryColor;
      fw = FontWeight.w600;
    } else {
      color = context.colorScheme.outline;
      fw = FontWeight.w400;
    }

    return InkWell(
      onTap: () => _setGender(gd),
      splashFactory: NoSplash.splashFactory,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                  fontWeight: fw,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

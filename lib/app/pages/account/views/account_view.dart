import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealmate/core.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
    with HiveMixin, StorageMixin {
  UserInfo? userInfo;

  @override
  void initState() {
    _listenUserInfoChange();
    super.initState();
  }

  Future<void> _listenUserInfoChange() async {
    userInfo = await getUserInfo();
    setState(() {});
    var box = await Hive.openBox<UserInfo>(AppKeys.userInfoBox);
    box.watch(key: AppKeys.userInfoKey).listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          userInfo = event.value;
        });
      });
    });
  }

  void _navigate(String routes) {
    Get.toNamed(routes, arguments: UserInfoInput(navigateBack: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localization.account)),
      body: DefaultPadding(
        child: _buildUserInfo(),
      ),
    );
  }

  Widget _buildUserInfo() {
    int? weight = userInfo?.getWeight();
    int? age = userInfo?.getAge();
    int? height = userInfo?.getHeight();
    String? goal = userInfo?.getFullGoal();
    String? mc = userInfo?.getFullMedicalCondition();

    return Column(
      children: [
        if (weight != null)
          _infoItem(context,
              iconData: Icons.monitor_weight_outlined,
              title: "kilogram",
              value: weight.toString(),
              onClicked: () => _navigate(Routes.mbi)),
        if (age != null)
          _infoItem(context,
              iconData: Icons.cake_outlined,
              title: context.localization.age.toLowerCase(),
              value: age.toString(),
              onClicked: () => _navigate(Routes.mbi)),
        if (height != null)
          _infoItem(
            context,
            iconData: Icons.settings_accessibility,
            title: "cm",
            value: height.toString(),
            onClicked: () => _navigate(Routes.height),
          ),
        if (goal != null)
          _infoItem(
            context,
            iconData: Icons.bookmark_add_outlined,
            title: context.localization.goal.toLowerCase(),
            value: goal.toString(),
            onClicked: () => _navigate(Routes.goal),
          ),
        if (mc != null)
          _infoItem(
            context,
            iconData: Icons.local_hospital_outlined,
            title: context.localization.medicalCondition.toLowerCase(),
            value: mc.toString(),
            onClicked: () => _navigate(Routes.medicalCondition),
          ),
      ],
    );
  }

  Widget _infoItem(
    BuildContext context, {
    required Function() onClicked,
    required IconData iconData,
    required String title,
    required String value,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            Icon(iconData),
            Space.horizontal(value: 12),
            Expanded(
              child: Text(
                value,
                style: context.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Space.horizontal(),
            Text(title),
          ],
        ),
      ),
    );
  }
}

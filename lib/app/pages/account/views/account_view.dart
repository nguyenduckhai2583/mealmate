import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  void _navigate(String routes) {
    Get.toNamed(routes, arguments: UserInfoInput(navigateBack: true));
  }

  Future<void> _navigateLanguage() async {
    await Get.toNamed(
      Routes.language,
      arguments: UserInfoInput(navigateBack: true),
    );
    controller.getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localization.account)),
      body: DefaultPadding(
        child: _buildUserInfo(context),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Obx(() {
      int? weight = controller.userInfo?.getWeight();
      int? age = controller.userInfo?.getAge();
      int? height = controller.userInfo?.getHeight();
      String? goal = controller.userInfo?.getFullGoal(context);
      String? mc = controller.userInfo?.getFullMedicalCondition(context);

      return Column(
        children: [
          if (weight != null)
            _infoItem(
              context,
              iconData: Icons.monitor_weight_outlined,
              title: "kilogram",
              value: weight.toString(),
              onClicked: () => _navigate(Routes.mbi),
            ),
          if (age != null) ...[
            const Space(),
            _infoItem(
              context,
              iconData: Icons.cake_outlined,
              title: context.localization.age.toLowerCase(),
              value: age.toString(),
              onClicked: () => _navigate(Routes.mbi),
            )
          ],
          if (height != null) ...[
            const Space(),
            _infoItem(
              context,
              iconData: Icons.settings_accessibility,
              title: "cm",
              value: height.toString(),
              onClicked: () => _navigate(Routes.height),
            )
          ],
          if (goal.hasCharacter) ...[
            const Space(),
            _infoItem(
              context,
              iconData: Icons.bookmark_add_outlined,
              title: context.localization.goal.toLowerCase(),
              value: goal.toString(),
              onClicked: () => _navigate(Routes.goal),
            )
          ],
          if (mc != null) ...[
            const Space(),
            _infoItem(
              context,
              iconData: Icons.local_hospital_outlined,
              title: context.localization.medicalCondition.toLowerCase(),
              value: mc.toString(),
              onClicked: () => _navigate(Routes.medicalCondition),
            ),
          ],
          if (controller.currentLocal != null) ...[
            const Space(),
            _infoItem(
              context,
              iconData: Icons.language_outlined,
              title: context.localization.language.toLowerCase(),
              value: LocalizationService.getLanguageName(
                controller.currentLocal!,
              ),
              onClicked: _navigateLanguage,
            )
          ]
        ],
      );
    });
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
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            children: [
              Icon(iconData),
              Space.horizontal(value: 12),
              Expanded(
                child: Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Space.horizontal(),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

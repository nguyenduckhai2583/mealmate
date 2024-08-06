import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mealmate/core.dart';

class PermissionManager {
  static Future<bool> _isAboveAndroid32() async {
    bool isAboveAndroidVer32 = false;
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      isAboveAndroidVer32 = deviceInfo.version.sdkInt > 32;
    }
    return isAboveAndroidVer32;
  }

  static Future<void> askGotoSettingToEnable(
    BuildContext context, {
    required String unableToAccessTitle,
    required String accessDeniedHint,
  }) async {
    await Get.dialog<void>(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(unableToAccessTitle),
        content: Text(accessDeniedHint),
        actions: [
          TextButton(
            child: Text(context.localization.goToSetting),
            onPressed: () async {
              await openAppSettings();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  ///
  ///Camera permission
  ///
  static Future<PermissionStatus> askCameraPermission(
    BuildContext context,
  ) async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.permanentlyDenied) {
      if (context.mounted) {
        var title = context.localization.unableAccessCamera;
        var des = context.localization.enableCameraPermission;
        await askGotoSettingToEnable(
          context,
          unableToAccessTitle: title,
          accessDeniedHint: des,
        );
      }
      return status;
    } else {
      return status;
    }
  }

  ///
  ///Photo permission
  ///
  static Future<PermissionStatus> askPhotoPermission(
    BuildContext context,
  ) async {
    bool isAboveAndroid32 = await _isAboveAndroid32();
    PermissionStatus status;
    if (Platform.isIOS || isAboveAndroid32) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.permanentlyDenied) {
      if (context.mounted) {
        var title = context.localization.unableAccessPhoto;
        var des = context.localization.enablePhotoPermission;

        await askGotoSettingToEnable(
          context,
          unableToAccessTitle: title,
          accessDeniedHint: des,
        );
      }
      return status;
    } else {
      return status;
    }
  }
}

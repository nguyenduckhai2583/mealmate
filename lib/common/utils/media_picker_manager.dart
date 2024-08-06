import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealmate/common/utils/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPickerManager {
  static Future<XFile?> takePhoto(BuildContext context) async {
    var permission = await PermissionManager.askCameraPermission(context);
    if (permission == PermissionStatus.granted) {
      XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);
      return result;
    }

    return null;
  }

  static Future<XFile?> selectPhoto(BuildContext context) async {
    var permission = await PermissionManager.askPhotoPermission(context);
    if (permission == PermissionStatus.granted) {
      XFile? result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      return result;
    }

    return null;
  }
}

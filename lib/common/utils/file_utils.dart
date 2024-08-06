import 'dart:io';

import 'package:mealmate/core.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static String _dirPath = "";
  static Future<String> getDir() async {
    if (_dirPath.isNullOrEmpty) {
      _dirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return _dirPath;
  }

  static String _getFileName(String path) {
    return path.split("/").last;
  }

  static Future<File> copyFileToStorage(String origin) async {
    String dir = await getDir();
    String fileName = _getFileName(origin);
    String filePath = "$dir/$fileName";

    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return await File(origin).copy(filePath);
  }
}
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FileDownloadHelper {
  static Future<void> saveFile(
    Uint8List bytes,
    String fileName,
  ) async {
    if (kIsWeb) {
      await _downloadWeb(bytes, fileName);
    } else {
      await _downloadMobile(bytes, fileName);
    }
  }

  static Future<void> _downloadMobile(
    Uint8List bytes,
    String fileName,
  ) async {
    final directory =
        await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
  }

  static Future<void> _downloadWeb(
    Uint8List bytes,
    String fileName,
  ) async {
    // Web saving handled via browser
    // No direct file system access
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HistoryProvider extends ChangeNotifier {
  List<FileSystemEntity>? history;

  int pathDirectoryLength = 0;

  void getFiles() async {
    try {
      // onLoading();
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      pathDirectoryLength = directory?.path.length ?? 0;
      final files = await directory!.list().toList();
      // print(files.length);
      history = files;
      // onSuccess();
      notifyListeners();
    } catch (e) {
      print(e);
      // onError();
    }
  }
  void deleteFile(FileSystemEntity file) async {
    await file.delete();
    getFiles();
  }
}

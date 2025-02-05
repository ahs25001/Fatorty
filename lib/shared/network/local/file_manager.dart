import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class FileManager {
  static Future<void> openFile(File file) async{
    await OpenFile.open(file.path);
  }

  static Future<File> saveFile(
      {required String name, required Document pdf}) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${root!.path}/$name');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

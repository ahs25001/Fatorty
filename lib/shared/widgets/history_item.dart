import 'dart:io';

import 'package:fatorty/shared/network/local/file_manager.dart';
import 'package:fatorty/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HistoryItem extends StatelessWidget {
  String path;
  int pathDirectoryLength;
  Function delete;

  HistoryItem({required this.path, required this.delete,required this.pathDirectoryLength, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            delete();
          },
          icon: Icons.delete,
          backgroundColor: redColor,
        )
      ]),
      child: InkWell(
        onTap: () {
          FileManager.openFile(File(path));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(colors: [redColor, amberColor])),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            path.substring(pathDirectoryLength + 1, (path).length - 11),
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}

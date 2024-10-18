import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fatorty/providers/history_provider.dart';
import 'package:fatorty/shared/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../shared/style/colors.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryProvider()..getFiles(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: redColor),
          centerTitle: true,
          title: Shimmer.fromColors(
            highlightColor: amberColor,
            baseColor: redColor,
            child: Text(
              "History",
              style: TextStyle(fontSize: 32.sp),
            ),
          ),
        ),
        body: Consumer<HistoryProvider>(builder: (context, value, child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: value.history?.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(
              height: 15.h,
            ),
            itemBuilder: (context, index) {
              return FadeInDown(
                delay: Duration(milliseconds: index==0?50:index*100),
                child: HistoryItem(
                    delete: () {
                      value.deleteFile(File(value.history![index].path));
                    },
                    path: value.history![index].path,
                    pathDirectoryLength: value.pathDirectoryLength),
              );
            },
          );
        }),
      ),
    );
  }
}

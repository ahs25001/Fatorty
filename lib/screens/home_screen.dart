import 'dart:ui';

import 'package:fatorty/providers/home_provider.dart';
import 'package:fatorty/screens/history_screen.dart';
import 'package:fatorty/shared/style/colors.dart';
import 'package:fatorty/shared/widgets/product_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home screen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeProvider()..getData(),
        builder: (context, child) => Scaffold(
              floatingActionButton: Consumer<HomeProvider>(
                builder: (context, value, child) => FloatingActionButton(
                  onPressed: () {
                    value.addProduct(context);
                  },
                  backgroundColor: redColor,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HistoryScreen.routeName);
                      },
                      icon: Icon(
                        Icons.history,
                        color: redColor,
                      )),
                  IconButton(
                      onPressed: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .saveSalesInvoice(() {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return PopScope(
                                canPop: false,
                                child: AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  content: Center(
                                    child: CircularProgressIndicator(
                                      color: redColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }, () {
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Complete sales invoice")));
                        });
                      },
                      icon: Icon(
                        Icons.save,
                        color: redColor,
                      )),
                ],
                centerTitle: true,
                title: Consumer<HomeProvider>(
                  builder: (context, provider, child) => Shimmer.fromColors(
                    highlightColor: amberColor,
                    baseColor: redColor,
                    child: Text(
                      provider.shopName,
                      style: TextStyle(fontSize: 32.sp),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Customer Name",
                            style:
                                TextStyle(fontSize: 18.sp, color: amberColor)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: TextFormField(
                                controller: Provider.of<HomeProvider>(context)
                                    .customerNameController,
                                cursorColor: amberColor,
                                style: TextStyle(
                                  color: amberColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide:
                                            BorderSide(color: redColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide:
                                            BorderSide(color: redColor)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide:
                                            BorderSide(color: redColor))))),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Table(
                      border: TableBorder.all(
                        width: 3,
                        color: redColor,
                      ),
                      children: [
                        TableRow(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Product Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: amberColor),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Product Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: amberColor),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Quantity",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: amberColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: AnimatedList(
                        controller:
                            Provider.of<HomeProvider>(context).scrollController,
                        key: Provider.of<HomeProvider>(context).listKey,
                        initialItemCount:
                            Provider.of<HomeProvider>(context).products.length,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                            position: animation.drive(Tween<Offset>(
                                begin: Offset(-1, 0), end: Offset.zero)),
                            child: ProductItem(
                                Provider.of<HomeProvider>(context)
                                    .products[index], () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .deleteProduct(index);
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

import 'package:fatorty/shared/network/local/file_manager.dart';
import 'package:fatorty/shared/network/local/shared_preferences_manager.dart';
import 'package:fatorty/shared/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;

enum HomeStatus { initial, loading, success, fail }

class HomeProvider extends ChangeNotifier {
  HomeStatus homeStatus = HomeStatus.initial;
  String name = "";
  String shopName = "";
  String shopAddress = "";
  String phoneNumber = "";
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<ProductModel> products = [];
  TextEditingController customerNameController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> getData() async {
    try {
      homeStatus = HomeStatus.loading;
      name = await SharedPreferencesManager.getString("name") ?? "";
      shopName = await SharedPreferencesManager.getString("shopName") ?? "";
      shopAddress =
          await SharedPreferencesManager.getString("shopAddress") ?? "";
      phoneNumber =
          await SharedPreferencesManager.getString("phoneNumber") ?? "";
      homeStatus = HomeStatus.success;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.fail;
      notifyListeners();
    }
  }

  Future<pw.Font> loadCustomFont() async {
    final ByteData bytes =
        await rootBundle.load('assets/fonts/Cairo-Medium.ttf');
    return pw.Font.ttf(bytes);
  }

  void saveSalesInvoice(
      Function onLoading, Function onSuccess, Function onError) async {
    try {
      onLoading();
      final bytes = await rootBundle.load("assets/images/phone_icon.png");
      final phoneIcon = bytes.buffer.asUint8List();
      if (products[products.length - 1].priceController.text.trim() != "" &&
          products[products.length - 1].nameController.text.trim() != "" &&
          products[products.length - 1].quantityController.text.trim() != "") {
        List<List<String>> data = products
            .map(
              (element) => [
                element.nameController.text.trim(),
                element.quantityController.text.trim(),
                element.priceController.text.trim(),
                (double.parse(element.priceController.text.trim()) *
                        double.parse(element.quantityController.text.trim()))
                    .toString()
              ],
            )
            .toList();
        double total = 0;
        for (var element in products) {
          total += double.parse(element.priceController.text.trim()) *
              double.parse(element.quantityController.text.trim());
        }
        final font = await loadCustomFont();
        pw.Document pdf = pw.Document();
        pdf.addPage(pw.MultiPage(
          build: (context) {
            return [
              pw.Center(
                child: pw.Text(
                  shopName,
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(fontSize: 20.sp, font: font),
                ),
              ),
              pw.Row(children: [
                pw.Text("Customer Name : ${customerNameController.text.trim()}",
                    style: pw.TextStyle(font: font),
                    textDirection: pw.TextDirection.rtl),
                pw.Spacer(),
                pw.Text("Date : ${DateFormat.yMd().format(DateTime.now())}",
                    style: pw.TextStyle(font: font),
                    textDirection: pw.TextDirection.rtl),
              ]),
              pw.TableHelper.fromTextArray(
                tableDirection: pw.TextDirection.rtl,
                cellStyle: pw.TextStyle(font: font),
                headers: [
                  "Product Name",
                  "Quantity",
                  "Price",
                  "Total",
                ],
                data: data,
              ),
              pw.SizedBox(height: 20.h),
              pw.Text("Total : $total EGP",
                  style: pw.TextStyle(font: font),
                  textDirection: pw.TextDirection.rtl),
              pw.SizedBox(height: 20.h),
              pw.Wrap(children: [
                pw.Text("Seller Name : $name ",
                    style: pw.TextStyle(font: font),
                    textDirection: pw.TextDirection.rtl),
                pw.SizedBox(width: 20.w),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Image(
                        pw.MemoryImage(phoneIcon),
                        width: 20.w,
                        height: 20.h,
                      ),
                      pw.Text(": $phoneNumber",
                          style: pw.TextStyle(font: font),
                          textDirection: pw.TextDirection.rtl),
                      pw.SizedBox(width: 20.w),
                      pw.Text("Address:",
                          style: pw.TextStyle(font: font),
                          textDirection: pw.TextDirection.rtl),
                      pw.SizedBox(
                          width: 300.w,
                          child: pw.Text(shopAddress,
                              // maxLines: 3,
                              style: pw.TextStyle(font: font),
                              textAlign: pw.TextAlign.center,
                              textDirection: pw.TextDirection.rtl))
                    ]),
              ])
            ];
          },
        ));
        final file = await FileManager.saveFile(
            name:
                "${customerNameController.text.trim()}_${DateTime.now().toString()}.pdf",
            pdf: pdf);
        onSuccess();
        FileManager.openFile(file);
      }
      else {
        onError();
      }
    } catch (e) {
      onError();
    }
  }

  void addProduct(BuildContext context) {
    if (customerNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Customer Name")));
    } else if (products.isEmpty ||
        products[products.length - 1].priceController.text != "" &&
            products[products.length - 1].nameController.text != "" &&
            products[products.length - 1].quantityController.text != "") {
      products.add(ProductModel());
      listKey.currentState?.insertItem(products.length - 1);
      scrollController.jumpTo(scrollController.position.maxScrollExtent+100.h);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Complete last product")));
    }
  }

  void deleteProduct(int index) {
    ProductModel product = products[index];
    products.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ProductItem(product, () {}),
      ),
    );
  }
}

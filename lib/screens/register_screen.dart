import 'package:fatorty/shared/widgets/register_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/register_provider.dart';
import '../shared/style/colors.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;

  late TextEditingController shopNameController;

  late TextEditingController shopAddressController;

  late TextEditingController phoneNumberController;
  late FocusNode nameFocusNode;
  late FocusNode shopNameFocusNode;
  late FocusNode shopAddressFocusNode;
  late FocusNode phoneNumberFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    shopNameController = TextEditingController();
    shopAddressController = TextEditingController();
    phoneNumberController = TextEditingController();
    nameFocusNode = FocusNode();
    shopNameFocusNode = FocusNode();
    shopAddressFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    shopNameController.dispose();
    shopAddressController.dispose();
    phoneNumberController.dispose();
    nameFocusNode.dispose();
    shopNameFocusNode.dispose();
    shopAddressFocusNode.dispose();
    phoneNumberFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      builder: (context, child) => Form(
        key: formKey,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Shimmer.fromColors(
                      baseColor: redColor,
                      highlightColor: amberColor,
                      direction: ShimmerDirection.ltr,
                      child: Column(
                        children: [
                          Text(
                            "Fatorty",
                            style: TextStyle(
                                fontSize: 36.sp, fontFamily: "PlayfairDisplay"),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          RegisterField(
                              onSubmit: () {
                                FocusScope.of(context)
                                    .requestFocus(shopNameFocusNode);
                              },
                              label: "Your Name",
                              controller: nameController,
                              focusNode: nameFocusNode),
                          SizedBox(
                            height: 20.h,
                          ),
                          RegisterField(
                              onSubmit: () {
                                FocusScope.of(context)
                                    .requestFocus(phoneNumberFocusNode);
                              },
                              label: "Shop Name",
                              controller: shopNameController,
                              focusNode: shopNameFocusNode),
                          SizedBox(
                            height: 20.h,
                          ),
                          RegisterField(
                              onSubmit: () {
                                FocusScope.of(context)
                                    .requestFocus(shopAddressFocusNode);
                              },
                              label: "Your Phone Number",
                              isPhoneNumber: true,
                              controller: phoneNumberController,
                              focusNode: phoneNumberFocusNode),
                          SizedBox(
                            height: 20.h,
                          ),
                          RegisterField(
                              onSubmit: () {
                                FocusScope.of(context).unfocus();
                              },
                              label: "Shop Address",
                              controller: shopAddressController,
                              focusNode: shopAddressFocusNode),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<RegisterProvider>(builder: (context, value, child) {
                    if (value.registerStatus == RegisterStatus.loading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                      ));
                    } else if (value.registerStatus == RegisterStatus.fail) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Something went wrong"),
                        backgroundColor: Colors.red,
                      ));
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r)),
                            backgroundBuilder: (context, states, child) {
                              return Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [redColor, amberColor]),
                                    borderRadius: BorderRadius.circular(18.r)),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: child,
                              );
                            },
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              value.saveData(
                                name: nameController.text,
                                shopName: shopNameController.text,
                                shopAddress: shopAddressController.text,
                                phoneNumber: phoneNumberController.text,
                                onSuccess:(){
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, HomeScreen.routeName, (route) => false);
                                }
                              );
                            }
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                            ),
                          )),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

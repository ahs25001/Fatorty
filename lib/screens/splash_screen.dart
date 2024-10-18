import 'package:animate_do/animate_do.dart';
import 'package:fatorty/main.dart';
import 'package:fatorty/providers/splash_screen_provider.dart';
import 'package:fatorty/screens/home_screen.dart';
import 'package:fatorty/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../shared/style/colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (value) async{
        SplashScreenProvider provider = SplashScreenProvider();
        await provider.getData();
        if(provider.name==null){
          Navigator.pushNamedAndRemoveUntil(
            context,
            RegisterScreen.routeName,
                (route) => false,
          );
        }else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
                (route) => false,
          );
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: amberColor,
          direction: ShimmerDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInLeft(
                child: Text(
                  "F",
                  style:
                      TextStyle(fontSize: 50.sp, fontFamily: "PlayfairDisplay"),
                ),
              ),
              FadeInDown(
                delay: Duration(milliseconds: 100),
                child: Text("a",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 200),
                child: Text("t",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
              FadeInDown(
                delay: Duration(milliseconds: 300),
                child: Text("o",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 400),
                child: Text("r",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
              FadeInDown(
                delay: Duration(milliseconds: 500),
                child: Text("t",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
              FadeInRight(
                delay: Duration(milliseconds: 600),
                child: Text("y",
                    style: TextStyle(
                        fontSize: 50.sp, fontFamily: "PlayfairDisplay")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

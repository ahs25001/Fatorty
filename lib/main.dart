import 'package:fatorty/screens/history_screen.dart';
import 'package:fatorty/screens/home_screen.dart';
import 'package:fatorty/screens/register_screen.dart';
import 'package:fatorty/screens/splash_screen.dart';
import 'package:fatorty/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: redColor,
            ),
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme(backgroundColor: backgroundColor)),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          HistoryScreen.routeName: (context) => HistoryScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
        },
      ),
    );
  }
}

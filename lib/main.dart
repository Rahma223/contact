import 'package:contact/core/app_colors.dart';
import 'package:contact/features/home/home_view.dart';
import 'package:contact/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.primaryColor,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ), 
      routes: {
        HomeView.id: (context) => const HomeView(),
        SplashView.id: (context) => const SplashView(),
      },
      
      initialRoute: SplashView.id,
    );
  }
}

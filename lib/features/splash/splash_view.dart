import 'package:contact/features/home/home_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  static String id = "SplashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}


class _SplashViewState extends State<SplashView> {
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }
  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, HomeView.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 80,
          width: 180,
          child: Image.asset('assets/images/Group 5.png'),
        ),
      ),
    );
  }
}

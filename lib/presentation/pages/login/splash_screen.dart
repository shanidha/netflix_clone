import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'dart:async';
import 'package:netflix_clone/presentation/pages/main_page/widgets/screen_main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
 
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScreenMainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor, 
      body: Center(
        child: Image.asset(
          'assets/images/netflix.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
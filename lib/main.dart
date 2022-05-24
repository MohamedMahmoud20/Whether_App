// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whether/Home.dart';
import 'Test.dart';

void main() {
  runApp( App());
}

class App extends StatefulWidget {

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin{
  late final controller =
  AnimationController(vsync: this, duration: const Duration(seconds: 1))
    ..repeat(reverse: true);

  late final Animation<double> animation =
  CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(backgroundColor: Colors.black, body:
        AnimatedSplashScreen(
          backgroundColor: Colors.lightBlue,
            splashIconSize: 500,
            splash: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child:
                    Lottie.asset(
                        'lib/Json/sPLASH.json',
                        fit: BoxFit.cover
                    ),),
                  FadeTransition(
                    opacity: animation,
                    child: Text(
                      "Weather",
                      style: TextStyle(fontSize: 23),
                    ),
                  )
                ],
              ),
            ),
            nextScreen: Search()))
    );
  }
}
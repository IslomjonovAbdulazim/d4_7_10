import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cups = 4;
  double value = 0.5;
  double prevValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                // Main Cup
                SizedBox(
                  height: 200,
                  width: 200,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: prevValue, end: value),
                    duration: Duration(milliseconds: 700),
                    builder: (context, v, child) {
                      return LiquidCircularProgressIndicator(
                        backgroundColor: Color(0xffF4F8FB),
                        valueColor: AlwaysStoppedAnimation(Color(0xff62CDFA)),
                        borderWidth: 3,
                        borderColor: Color(0xff62CDFA),
                        value: v,
                      );
                    },
                  ),
                ),

                // Status & Control
                SizedBox(height: 20),
                AnimatedFlipCounter(
                  value: cups,
                  suffix: " cups",
                  duration: Duration(milliseconds: 700),
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff62CDFA),
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    CupertinoButton(
                      color: Colors.red,
                      onPressed: () {
                        prevValue = value;
                        cups = 0;
                        value = 0;
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(100),
                      padding: EdgeInsets.zero,
                      child: Icon(
                        CupertinoIcons.refresh_bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

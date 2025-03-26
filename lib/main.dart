import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:device_preview/device_preview.dart';
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
  int cups = 0;
  double value = 0;

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
                  child: LiquidCircularProgressIndicator(
                    backgroundColor: Color(0xffF4F8FB),
                    valueColor: AlwaysStoppedAnimation(Color(0xff62CDFA)),
                    borderWidth: 3,
                    borderColor: Color(0xff62CDFA),
                    value: value,
                  ),
                ),

                // Status & Control
                SizedBox(height: 20),
                AnimatedFlipCounter(
                  value: cups,
                  suffix: " cups",
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff62CDFA),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

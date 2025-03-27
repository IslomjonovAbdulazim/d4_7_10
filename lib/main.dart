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
  int cups = 0;
  double value = 0.0;
  double prevValue = 0.0;
  int currentCup = 0;

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
                  duration: Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff62CDFA),
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        color: Color(0xff62CDFA),
                        borderRadius: BorderRadius.circular(15),
                        onPressed: () {
                          double result = 150 / 2000;
                          prevValue = value;
                          value += result;
                          if (value >= 1) {
                            value = 1;
                          } else {
                            cups++;
                          }
                          setState(() {});
                        },
                        child: Text(
                          "150ml",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CupertinoButton(
                        color: Color(0xff62CDFA),
                        borderRadius: BorderRadius.circular(15),
                        onPressed: () {
                          double result = 250 / 2000;
                          prevValue = value;
                          value += result;
                          if (value >= 1) {
                            value = 1;
                          } else {
                            cups++;
                          }
                          setState(() {});
                        },
                        child: Text(
                          "250ml",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Cups
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          currentCup = index + 1;
                          prevValue = value;
                          value = currentCup * .125;
                          cups = currentCup;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/cup.png",
                              ),
                              colorFilter: ColorFilter.mode(
                                index >= currentCup ? Colors.grey : Colors.transparent,
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.red,
                  onPressed: () {
                    prevValue = value;
                    cups = 0;
                    value = 0;
                    currentCup = 0;
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.refresh_bold,
                      color: Colors.white,
                    ),
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

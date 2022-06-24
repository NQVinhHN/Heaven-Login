import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    offset = Tween<Offset>(begin: const Offset(0.0, 3.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          onFinished: () {
            controller.forward();
          },
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'Chào mừng bạn đã tới với Thiên Đường\n',
              textStyle: const TextStyle(
                fontSize: 50,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              speed: const Duration(milliseconds: 70),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heaven_login/popup_messege.dart';
import 'package:heaven_login/screen/third_screen.dart';
import 'package:page_transition/page_transition.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    dataLoadFunction(); // this function gets called
  }

  dataLoadFunction() {
    setState(() {
      MyAlertState.progress = 0;
      MyAlertState.timer?.cancel();
      MyAlertState.timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (Timer timer) {
          EasyLoading.showProgress(MyAlertState.progress,
              status:
                  '${(MyAlertState.progress * 100).toStringAsFixed(0)}%\n\nServer Thiên Đường\nLoading...');
          MyAlertState.progress += 0.03;
          if (MyAlertState.progress >= 1) {
            timer.cancel();
            EasyLoading.dismiss();
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(seconds: 3),
                type: PageTransitionType.fade,
                child: ThirdScreen(),
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: dataLoadFunction(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heaven_login/screen/second_screen.dart';

class MyAlert extends StatefulWidget {
  MyAlert({Key? key}) : super(key: key);
  static bool hasPop = true;
  static bool successloading = false;
  @override
  State<MyAlert> createState() => MyAlertState();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyAlertState extends State<MyAlert> {
  static Timer? timer;
  static late double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            showAlertDialog(context);
          },
          child: const Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget signOutButton = TextButton(
    child: const Text(
      "Đăng xuất",
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context, MyAlert.hasPop = false);
      MyAlertState.progress = 0;
      MyAlertState.timer?.cancel();
      MyAlertState.timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (Timer timer) {
          EasyLoading.showProgress(MyAlertState.progress,
              status:
                  '${(MyAlertState.progress * 100).toStringAsFixed(0)}%\n\nLoading');
          MyAlertState.progress += 0.03;
          if (MyAlertState.progress >= 1) {
            timer.cancel();
            EasyLoading.dismiss();
            Get.to(const SecondScreen());
          }
        },
      );
    },
  );
  Widget cancelButton = TextButton(
    child: Text(
      "Hủy",
      style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Bạn có chắc là muốn đăng xuất?"),
    actions: [
      signOutButton,
      cancelButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

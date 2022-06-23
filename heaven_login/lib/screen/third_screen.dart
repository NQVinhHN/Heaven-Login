import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heaven_login/popup_messege.dart';

import 'final_screen.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({Key? key}) : super(key: key);
  bool finished = false;
  bool passwordVisible = false;
  bool hasPop = MyAlert.hasPop = true;
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('https://i.postimg.cc/4yxkb0P9/heaven.png'),
          ),
        ),
        child: Visibility(
          visible: MyAlert.hasPop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                onFinished: () {
                  controller.forward();
                },
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Chào mừng tới Thiên Đường\nYêu cầu đăng nhập',
                    textStyle: const TextStyle(
                      fontSize: 30,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 70),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SlideTransition(
                position: offset,
                child: Center(
                  child: Card(
                    child: Container(
                      width: 350,
                      height: 200,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                                labelText:
                                    'Email/ Số điện thoại/ Tên đăng nhập ',
                              ),
                            ),
                            TextFormField(
                              obscureText: !widget.passwordVisible,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                                labelText: 'Mật khẩu',
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // added line
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        widget.passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.passwordVisible =
                                              !widget.passwordVisible;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Quên?',
                                      style: TextStyle(color: Colors.blue[300]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[200]),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        MyAlert.hasPop = !MyAlert.hasPop;
                                      });
                                      MyAlertState.progress = 0;
                                      MyAlertState.timer?.cancel();
                                      MyAlertState.timer = Timer.periodic(
                                        const Duration(milliseconds: 100),
                                        (Timer timer) {
                                          EasyLoading.showProgress(
                                              MyAlertState.progress,
                                              status:
                                                  '${(MyAlertState.progress * 100).toStringAsFixed(0)}%\n\nLoading');
                                          MyAlertState.progress += 0.03;
                                          if (MyAlertState.progress >= 1) {
                                            timer.cancel();
                                            EasyLoading.dismiss();
                                            Get.to(const FinalScreen());
                                          }
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Đăng nhập',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Đăng ký',
                                  style: TextStyle(color: Colors.blue[300]),
                                ),
                                const Spacer(),
                                Text(
                                  'Đăng nhập bằng SMS',
                                  style: TextStyle(color: Colors.blue[300]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

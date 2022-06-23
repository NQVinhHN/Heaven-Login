import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heaven_login/popup_messege.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: _App(),
      builder: EasyLoading.init(),
    ),
  );
  configLoading();
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ButterFlyAssetVideo(),
    );
  }
}

class ButterFlyAssetVideo extends StatefulWidget {
  const ButterFlyAssetVideo({Key? key}) : super(key: key);

  @override
  ButterFlyAssetVideoState createState() => ButterFlyAssetVideoState();
}

class ButterFlyAssetVideoState extends State<ButterFlyAssetVideo> {
  late VideoPlayerController _controller;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/earth.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        Visibility(
          visible: MyAlert.hasPop,
          child: Padding(
            padding: const EdgeInsets.only(top: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.white,
                      checkColor: Colors.red,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'Server Earth',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                MyAlert(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

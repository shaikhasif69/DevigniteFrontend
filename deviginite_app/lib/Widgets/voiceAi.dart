import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class VoiceAi extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VoiceAi();
    throw UnimplementedError();
  }
}

class _VoiceAi extends ConsumerState<VoiceAi> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  late double? roboWidth = null;

  bool listenMode = false;
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    ref.read(FLutterTTSProvider.notifier).controller = controller;
    ;
    slideAnimation = Tween(begin: Offset.zero, end: Offset(0.0, 0.2))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.bounceInOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose

    // ref.read(FLutterTTSProvider.notifier).controller.dispose();
  }

  void changeRoboPosition() {
    setState(() {
      roboWidth = 100.0;
    });
  }

  Widget build(BuildContext cotext) {
    ref.watch(FLutterTTSProvider);
    String solution = ref.read(FLutterTTSProvider.notifier).solutionString;
    print("called Ai");
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: slideAnimation,
            child: AnimatedContainer(
                // color: Colors.amber,
                height: ref.read(FLutterTTSProvider.notifier).roboheight,
                width: ref.read(FLutterTTSProvider.notifier).roboWidth,
                duration: Duration(seconds: 1),
                child: LottieBuilder.asset(
                    alignment: Alignment.bottomCenter,
                    "assets/images/robot.json")),
          ),
          Center(
            child: Card(
              color: Color.fromARGB(255, 100, 150, 186),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  ref.read(FLutterTTSProvider.notifier).data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          ref.read(FLutterTTSProvider.notifier).listenModeBool
              ? Center(
                  child: Container(
                      color: Color.fromARGB(255, 75, 112, 139),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: LottieBuilder.asset(
                              height: 100,
                              width: 200,
                              "assets/images/loading.json"))),
                )
              : const SizedBox(),
          ref.read(FLutterTTSProvider.notifier).fetchingResult
              ? Center(
                  child: Container(
                      color: Color.fromARGB(255, 75, 112, 139),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: LottieBuilder.asset(
                              height: 300,
                              width: 200,
                              "assets/images/myAiLoading.json"))),
                )
              : const SizedBox(),
          ref.read(FLutterTTSProvider.notifier).fetchingResult
              ? Center(
                  child: Container(
                      color: Color.fromARGB(255, 75, 112, 139),
                      child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Fetching Result",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ))),
                )
              : const SizedBox(),
          ref.read(FLutterTTSProvider.notifier).solution
              ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        color: Color.fromARGB(255, 75, 112, 139),
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                solution))),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

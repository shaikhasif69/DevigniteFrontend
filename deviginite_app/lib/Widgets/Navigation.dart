import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:deviginite_app/provider/flutterTts2provider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class NavigateAi extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NavigateAi();
    throw UnimplementedError();
  }
}

class _NavigateAi extends ConsumerState<NavigateAi>
    with TickerProviderStateMixin {
  Widget build(context) {
    ref.watch(FLutterTTSProvider2);
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimatedContainer(
              // color: Colors.amber,
              height: ref.read(FLutterTTSProvider2.notifier).roboHeight,
              width: ref.read(FLutterTTSProvider2.notifier).roboWidth,
              duration: Duration(seconds: 1),
              child: LottieBuilder.asset(
                  alignment: Alignment.bottomCenter,
                  "assets/images/robot.json")),
          const Center(
            child: Card(
              color: Color.fromARGB(255, 100, 150, 186),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Where Do You Want to Navigate..?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              color: Color.fromARGB(255, 100, 150, 186),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  ref.read(FLutterTTSProvider2.notifier).data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          ref.read(FLutterTTSProvider2.notifier).listenMood
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
        ],
      ),
    );
  }
}

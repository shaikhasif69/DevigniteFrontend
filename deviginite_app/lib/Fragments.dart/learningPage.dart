import 'package:deviginite_app/Widgets/SubjectCards.dart';
import 'package:deviginite_app/model/subject.dart';
import 'package:deviginite_app/provider/Student/learningPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BlindHomePage extends ConsumerStatefulWidget {
  const BlindHomePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BlindHomePage();
  }
}

const ballSize = 20.0;

class _BlindHomePage extends ConsumerState<BlindHomePage> {
  double ballSize = 20.0;
  double step = 10.0;
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.horizontalAndVertical;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  final FlutterTts flutterTts = FlutterTts();

  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Stack(
          children: [
            SubjectCards(),
            Ball(_x, _y),
            Align(
              alignment: const Alignment(0, 0.8),
              child: Joystick(
                period: Duration(milliseconds: 400),
                stick: ElevatedButton(
                  child: Text(""),
                  onPressed: () {},
                ),
                mode: _joystickMode,
                listener: (details) {
                  Vibration.vibrate(duration: 100);
                  int data =
                      ref.read(LearningPageProvider.notifier).selectedSubIs();

                  if (data >= 5) {
                    ref.read(LearningPageProvider.notifier).selectSub(0);
                  } else {
                    ref
                        .watch(LearningPageProvider.notifier)
                        .selectSub(data + 1);
                  }
                  flutterTts.speak(subjectList[ref
                      .watch(LearningPageProvider.notifier)
                      .selectedSubIs()]['name']);

                  // ref.read(LearningPageProvider.notifier).selectSub(0);
                  print("x is: " + details.x.toString());
                  print("y is: " + details.y.toString());
                  _x = _x + step * details.x;
                  _y = _y + step * details.y;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}

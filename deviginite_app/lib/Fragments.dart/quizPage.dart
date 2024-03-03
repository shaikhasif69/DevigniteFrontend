import 'package:deviginite_app/model/quiz.dart';
import 'package:deviginite_app/provider/Student/quizProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

class QuizScreen extends ConsumerStatefulWidget {
  // final String jsonData;
  // const QuizScreen({Key? key, required this.jsonData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _QuizScreenState();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  // List<QuizQuestion> questionList = myData["something"];
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
  int currentQuestionIndex = 0;
  int philosophyScore = 0;
  int economicsScore = 0;
  int lawScore = 0;
  bool answered = false;
  @override
  void initState() {
    flutterTts.awaitSpeakCompletion(true);
    // ref.watch(QuizProvider.notifier).fetchData(true);
    // TODO: implement initState

    flutterTts.awaitSpeakCompletion(true);
    // await flutterTts.setVolume(volume);

    // await flutterTts.setPitch(pitch);
    // flutterTts.speak(listOfQuestions[0]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(QuizProvider.notifier).fetchData(true);
    });
    void setupTextToSpeech() async {
      await flutterTts.setPitch(15);
    }

    super.initState();
  }

  String ans = "yes";
  @override
  Widget build(BuildContext context) {
    ref.watch(QuizProvider);
    // setupTextToSpeech();
    List listOfQuestions = ref.watch(QuizProvider.notifier).getData();
    if (listOfQuestions.isNotEmpty && currentQuestionIndex == 0) {
      print("q 1 " + listOfQuestions[currentQuestionIndex]);
      flutterTts.speak("Welcome to Quiz  your first question is      ..  " +
          listOfQuestions[currentQuestionIndex]);
    }
    print("object");
    print(listOfQuestions);
    // QuizData quizData = QuizData.fromJson(json.decode(widget.myData));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: listOfQuestions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Simple Quiz App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        _questionWidget(listOfQuestions),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ans == "yes" ? Colors.green : null),
                            child: Text("Yes"),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ans == "no" ? Colors.green : null),
                              child: Text("No"),
                              onPressed: () {}),
                        ),
                        // _answerList(listOfQuestions),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.8),
                    child: Joystick(
                      period: Duration(milliseconds: 800),
                      stick: ElevatedButton(
                        child: Text(""),
                        onPressed: () {},
                        onLongPress: () {
                          bool isLastQuestion = currentQuestionIndex ==
                              listOfQuestions.length - 1;
                          Vibration.vibrate(duration: 100);

                          setState(() {});
                          if (ans == "yes") {
                            print(currentQuestionIndex);
                            // Increment score based on the subject
                            if (currentQuestionIndex <= 4) {
                              philosophyScore++;
                            } else if (currentQuestionIndex <= 9) {
                              economicsScore++;
                            } else if (currentQuestionIndex <= 14) {
                              lawScore++;
                            }
                          }
                          if (!isLastQuestion) {
                            currentQuestionIndex++;
                            flutterTts.speak(ans +
                                " selected Next Question ..   " +
                                listOfQuestions[currentQuestionIndex]);
                          } else {
                            // Show score dialog
                            showDialog(
                              context: context,
                              builder: (_) => _showScoreDialog(),
                            );
                          }
                        },
                      ),
                      mode: _joystickMode,
                      listener: (details) {
                        Vibration.vibrate(duration: 100);
                        setState(() {
                          if (ans == "yes") {
                            ans = "no";
                            flutterTts.speak("Long press To Select No");
                          } else {
                            ans = "yes";
                            flutterTts.speak("Long press To Select Yes");
                          }

                          // ans = "yes";
                        });

                        // ref.read(LearningPageProvider.notifier).selectSub(0);
                        print("x is: " + details.x.toString());
                        print("y is: " + details.y.toString());
                        _x = _x + step * details.x;
                        _y = _y + step * details.y;
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _questionWidget(listOfQuestions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${15}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            listOfQuestions[currentQuestionIndex],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  // _nextButton(listOfQuestions) {
  //   bool isLastQuestion = currentQuestionIndex == listOfQuestions.length - 1;
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.5,
  //     height: 48,
  //     child: ElevatedButton(
  //       child: Text(isLastQuestion ? "Submit" : "Next"),
  //       onPressed: answered
  //           ? () {
  //               setState(() {
  //                 answered = false;
  //                 if (!isLastQuestion) {
  //                   currentQuestionIndex++;
  //                 } else {
  //                   // Show score dialog
  //                   showDialog(
  //                     context: context,
  //                     builder: (_) => _showScoreDialog(),
  //                   );
  //                 }
  //               });
  //             }
  //           : null,
  //     ),
  //   );
  // }

  _showScoreDialog() {
    return AlertDialog(
      title: Text("Scores"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Philosophy: $philosophyScore"),
          Text("Economics: $economicsScore"),
          Text("Law: $lawScore"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex = 0;
              philosophyScore = 0;
              economicsScore = 0;
              lawScore = 0;
            });
          },
          child: Text("Exit"),
        ),
      ],
    );
  }
}

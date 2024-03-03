import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/questions.dart';
import '../services/Quiz.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final String topicType;
  // List<dynamic> questionlenght;
  dynamic optionsList;
  var leng = questions.length;
  QuizScreen(
      {super.key,
      // required this.questionlenght,
      required this.optionsList,
      required this.topicType});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var length = questions.length;
  
  Map<String, int> subjectScores = {
    'Philosophy': 0,
    'Economics': 0,
    'Law': 0,
  };
  int questionTimerSeconds = 20;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  // List optionsLetters = ["A.", "B.", "C.", "D."];
  List optionsLetters = ["A.", "B."];

  void startTimerOnQuestions() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (questionTimerSeconds > 0) {
            questionTimerSeconds--;
          } else {
            _timer?.cancel();
            navigateToNewScreen();
          }
        });
      }
    });
  }

  void stopTime() {
    _timer?.cancel();
  }

  void navigateToNewScreen() {
    if (_questionNumber < length) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {
        _questionNumber++;
        isLocked = false;
      });
      // _resetQuestionLocks();
      startTimerOnQuestions();
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: score,
            totalQuestions: length,
            whichTopic: widget.topicType,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    // _resetQuestionLocks();
    startTimerOnQuestions();
  }

  // Future<void> fetchQuizQuestions() async {
  //   try {
  //     print("fetchQuizQuestions called");
  //     var something = true;
  //     final response = await Quiz.getQuiz(something);
  //     print("response: $response");
  //     if (response != null && response['success']) {
  //       final quizData = response['random_quiz_questions'];
  //       print("Quiz data: $quizData");
  //       setState(() {
  //         // Update widget properties with fetched questions
  //         widget.questionlenght = quizData.values.toList();
  //         widget.optionsList = quizData.keys.toList();
  //       });
  //     } else {
  //       print('No data or unsuccessful response from the backend!');
  //     }
  //   } catch (e) {
  //     print('Error fetching quiz questions: $e');
  //   }
  // }

  void handleAnswer(String subject, bool isYes) {
    if (isYes) {
      setState(() {
        subjectScores[subject] = (subjectScores[subject] ?? 0) + 1;
      });
    }
    // Handle "No" answer if needed
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xFF5170FD);
    const Color bgColor = Color(0xFF4993FA);

    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgColor3,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.topicType} Riddles",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                          weight: 10,
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            minHeight: 20,
                            value: 1 - (questionTimerSeconds / 20),
                            backgroundColor: Colors.blue.shade100,
                            color: Colors.blueGrey,
                            valueColor: const AlwaysStoppedAnimation(bgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question $_questionNumber/${length}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade500),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 15,
                              onPageChanged: (value) {
                                setState(() {
                                  _questionNumber = value + 1;
                                  isLocked = false;
                                  // _resetQuestionLocks();
                                });
                              },
                              itemBuilder: (context, index) {
                                int a = 0;
                                int b = 0;
                                int c = 0;

                                var subject = '';
                                final myquestions =
                                    questions[subject][index];
                                    print("this si the ");
                                if (index <=4) {
                                    subject = "Philosophy";
                                    final myquestions =
                                    questions[subject][a];
                                    print("this si the ");
                                    a+=1;
                                }
                                else if(index <= 9){
                                  subject =  "Economics";
                                  final myquestions =
                                    questions[subject][b];
                                    print("this si the ");
                                  b+=1;

                                }
                                else if(index <= 14){
                                  subject = "Law";
                                  final myquestions =
                                    questions[subject][c];
                                    print("this si the ");
                                  c+=1;
                                }
                                
                                var optionsIndex = widget.optionsList[index];

                                return Column(
                                  children: [
                                    Text(
                                      myquestions.text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),

                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       scorePhilosophy += 1;
                                    //       print("hello!0");
                                    //       print(scorePhilosophy);
                                    //       if (!myquestions.isLocked) {
                                    //         setState(() {
                                    //           myquestions.isLocked = true;
                                    //           // myquestions
                                    //           //         .selectedWiidgetOption =
                                    //           //     questionOption;
                                    //         });
                                    //         // print("something : " +  questionOption);

                                    //         isLocked = myquestions.isLocked;
                                    //         print("this is isLocked: " );
                                    //         print(isLocked);

                                    //       }
                                    //       // goToNextQuestion();
                                    //     });
                                    //   },
                                    //   child: Text('Yes'),
                                    // ),
                                    // SizedBox(height: 8),
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     // goToNextQuestion();
                                    //   },
                                    //   child: Text('No'),
                                    // ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          var color = Colors.grey.shade200;

                                          var questionOption =
                                              myquestions.options[index];
                                          final letters = optionsLetters[index];
                                          // print("this is the questionOptionN: " + myquestions);

                                          if (myquestions.isLocked) {
                                            if (questionOption ==
                                                myquestions
                                                    .selectedWiidgetOption) {
                                              color = questionOption.isCorrect
                                                  ? Colors.green
                                                  : Colors.red;
                                            } else if (questionOption
                                                .isCorrect) {
                                              color = Colors.green;
                                            }
                                          }
                                          return InkWell(
                                            onTap: () {
                                              // fetchQuizQuestions();
                                              print(optionsIndex);
                                              print("the options Index!");
                                              stopTime();
                                              if (!myquestions.isLocked) {
                                                setState(() {
                                                  myquestions.isLocked = true;
                                                  myquestions
                                                          .selectedWiidgetOption =
                                                      questionOption;
                                                });
                                                // print("something : " +  questionOption);

                                                isLocked = myquestions.isLocked;
                                                if (myquestions
                                                    .selectedWiidgetOption
                                                    .isCorrect) {
                                                  score++;
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 45,
                                              padding: const EdgeInsets.all(10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: color),
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "$letters ${questionOption.text}",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  isLocked == true
                                                      ? questionOption.isCorrect
                                                          ? const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(
                                                              Icons.cancel,
                                                              color: Colors.red,
                                                            )
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          isLocked
                              ? buildElevatedButton()
                              : const SizedBox.shrink(),
                        ],
                      ),
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

  // void _resetQuestionLocks() {
  //   for (var question in widget.questionlenght) {
  //     question.isLocked = false;
  //   }
  //   questionTimerSeconds = 20;
  // }

  ElevatedButton buildElevatedButton() {
    //  const Color bgColor3 = Color(0xFF5170FD);
    const Color cardColor = Color(0xFF4993FA);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(cardColor),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width * 0.80, 40),
        ),
        elevation: MaterialStateProperty.all(4),
      ),
      onPressed: () {
        if (_questionNumber < length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
          setState(() {
            _questionNumber++;
            isLocked = false;
          });
          // _resetQuestionLocks();
          startTimerOnQuestions();
        }
        // else {
        //   _timer?.cancel();
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ResultsScreen(
        //         score: score,
        //         totalQuestions: widget.questionlenght.length,
        //         whichTopic: widget.topicType,
        //       ),
        //     ),
        //   );
        // }
      },
      child: Text(
        _questionNumber < length
            ? 'Next Question'
            : 'Result',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

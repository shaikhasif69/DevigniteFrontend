import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets copy/flash_card_widget.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../widgets copy/linear_progress_indicator_widget.dart';
import 'quiz_screen.dart';

class NewCard extends StatefulWidget {
  final String topicName;
  final List<dynamic> typeOfTopic;
  const NewCard(
      {super.key, required this.topicName, required this.typeOfTopic});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    //const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    const Color cardColor = Color(0xFF4993FA);

    // Get a list of 4 randomly selected Questions objects

    Map<dynamic, dynamic> randomQuestionsMap =
        getRandomQuestionsAndOptions(widget.typeOfTopic, 4);

    Map<dynamic, dynamic> questions = {
      "Philosophy": [
        "Do you appreciate the ambiguity and complexity inherent in philosophical questions?",
        "Do you like reading philosophical texts or discussing philosophical concepts with others?",
        "Do you find joy in exploring ethical dilemmas and moral principles?",
        "Do you like studying the history of philosophy and the contributions of famous philosophers?",
        "Do you find satisfaction in contemplating different philosophical theories and ideas?"
      ],
      "Economics": [
        "Do you enjoy discussing the impact of government policies on the economy?",
        "Do you enjoy analyzing market trends and economic indicators?",
        "Do you appreciate the role of economics in addressing global issues such as poverty",
        "Do you find satisfaction in learning about economic theories such as supply and demand",
        "Do you like studying how individuals"
      ],
      "Law": [
        "Do you find satisfaction in advocating for legal reforms or representing clients in legal matters?",
        "Do you find interest in understanding how laws shape society?",
        "Do you like discussing the role of law in promoting justice and protecting rights?",
        "Do you find satisfaction in learning about legal principles and precedents?",
        "Do you enjoy debating legal issues and exploring different interpretations of the law?"
      ]
    };

    List<dynamic> randomQuestions = randomQuestionsMap.keys.toList();
    dynamic randomOptions = randomQuestionsMap.values.toList();

    return Scaffold(
      backgroundColor: bgColor3,
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(right: 18.0),
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    MyProgressIndicator(
                      questionlenght: randomQuestions,
                      optionsList: randomOptions,
                      topicType: widget.topicName,
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.92,
              //   height: MediaQuery.of(context).size.height * 0.60,
              //   child: AppinioSwiper(
              //     padding: const EdgeInsets.all(10),
              //     loop: true,
              //     backgroundCardsCount: 2,
              //     swipeOptions: const AppinioSwipeOptions.all(),
              //     unlimitedUnswipe: true,
              //     controller: controller,
              //     unswipe: _unswipe,
              //     onSwipe: _swipe,
              //     onEnd: _onEnd,
              //     cardsCount: randomQuestions.length,
              //     cardsBuilder: (BuildContext context, int index) {
              //       var cardIndex = randomQuestions[index];
              //       return FlipCardsWidget(
              //         bgColor: cardColor,
              //         cardsLenght: randomQuestions.length,
              //         currentIndex: index + 1,
              //         answer: cardIndex.correctAnswer.text,
              //         question: cardIndex.text,
              //         currentTopic: widget.topicName,
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cardColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () => controller.unswipe(),
                    child: const Text(
                      "Reorder Cards",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cardColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.sizeOf(context).width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            // questionlenght: questions,
                            optionsList: randomOptions,
                            topicType: widget.topicName,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Start Quiz",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<dynamic, dynamic> getRandomQuestionsAndOptions(
  List<dynamic> allQuestions,
  int count,
) {
  final randomQuestions = <dynamic>[];
  final randomOptions = <dynamic>[];
  final random = Random();

  if (count >= allQuestions.length) {
    count = allQuestions.length;
  }

  while (randomQuestions.length < count) {
    final randomIndex = random.nextInt(allQuestions.length);
    final selectedQuestion = allQuestions[randomIndex];

    if (!randomQuestions.contains(selectedQuestion)) {
      randomQuestions.add(selectedQuestion);
      randomOptions.add(selectedQuestion.options);
    }
  }
  print("this are the itterable question: ");
  print(Map.fromIterables(randomQuestions, randomOptions));
  return Map.fromIterables(randomQuestions, randomOptions);
}

// List<dynamic> getRandomQuestions(List<dynamic> allQuestions, int count) {
//   if (count >= allQuestions.length) {
//     return List.from(allQuestions);
//   }
//   List<dynamic> randomQuestions = [];

//   List<int> indexes = List.generate(allQuestions.length, (index) => index);
//   final random = Random();

//   while (randomQuestions.length < count) {
//     final randomIndex = random.nextInt(indexes.length);
//     final selectedQuestionIndex = indexes[randomIndex];
//     final selectedQuestion = allQuestions[selectedQuestionIndex];
//     randomQuestions.add(selectedQuestion);

//     indexes.removeAt(randomIndex);
//   }
//   return randomQuestions;
// }

// void _swipe(int index, AppinioSwiperDirection direction) {
//   print("the card was swiped to the: ${direction.name}");
//   print(index);
// }

void _unswipe(bool unswiped) {
  if (unswiped) {
    print("SUCCESS: card was unswiped");
  } else {
    print("FAIL: no card left to unswipe");
  }
}

void _onEnd() {
  print("end reached!");
}

import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Map<String, List> data = {
  "quiz": [
    {"title": "Quiz", "subtitle": "Quiz "}
  ],
  'assignment': [
    {
      "title": "Maths",
      "subTitle": "Pythagorus",
      'image': "assets/images/py.jpeg"
    },
    {
      "title": "History",
      "subTitle": "Battle Of Kondhana",
      'image': "assets/images/battle.png"
    },
    {
      "title": "geography",
      "subTitle": "Amazon Forest",
      'image': "assets/images/amazon.jpeg"
    },
    {
      "title": "English",
      "subTitle": "Where the Mind is Without Fear",
      'image':
          "assets/images/Where_the_mind_is_without_fear_by_ritwik_mango.jpg"
    },
    {
      "title": "Marathi",
      "subTitle": "Chotte se Bahen Bhau",
      'image': "assets/images/chotte.jpeg"
    },
  ]
};

class HomePageSegmentNotifier extends StateNotifier<Map<String, List>> {
  HomePageSegmentNotifier({required this.ref}) : super(data);
  dynamic ref;
  Color bg = Color.fromARGB(255, 175, 213, 235);
  String selectedSeg = 'quiz';
  late Function update;
  int SelectedInt = -1;
  late ItemScrollController scrollController;
  void selectSeg(String num) {
    SelectedInt = -1;
    print("ss " + num);
    selectedSeg = num;
    state = {};
    state = data;
  }

  void selectIndex(int num) {
    print("numi: " + num.toString());
    if (num >= 0 && num < state[selectedSeg]!.length) {
      SelectedInt = num;
      scrollController.scrollTo(
          index: SelectedInt, duration: Duration(milliseconds: 1000));
    } else if (num == -1) {
      SelectedInt = state[selectedSeg]!.length - 1;
      scrollController.scrollTo(
          index: SelectedInt, duration: Duration(milliseconds: 1000));
    } else if (num == state[selectedSeg]!.length) {
      SelectedInt = 0;
      scrollController.scrollTo(
          index: SelectedInt, duration: Duration(milliseconds: 1000));
    }

    state = {};

    state = data;
  }
}

final HomePagesegmentProvider =
    StateNotifierProvider<HomePageSegmentNotifier, Map<String, List>>(
        (ref) => HomePageSegmentNotifier(ref: ref));

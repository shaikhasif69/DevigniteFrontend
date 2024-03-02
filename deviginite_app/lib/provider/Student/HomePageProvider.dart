import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HpomePageSegmentListenerProvider extends StateNotifier<int> {
  HpomePageSegmentListenerProvider() : super(0);
  void selectSeg(int num) {
    print(num);
    state = num;
  }

  int selectedSegment() {
    return state;
  }
}

class HomePageAssigmentListenerProvider extends StateNotifier<int> {
  HomePageAssigmentListenerProvider() : super(0);
  void selectAssignment(int num, ScrollController _assignmentController) {
    print(num);
    state = num;
    _scrollDown(_assignmentController);
  }

  void _scrollDown(ScrollController _assignmentController) {
    _assignmentController.jumpTo(
      state.toDouble() * 110,
    );
  }

  int selectedAssignment() {
    return state;
  }
}

class HomePageCoursesListenerProvider extends StateNotifier<int> {
  HomePageCoursesListenerProvider() : super(0);
  void selectCourse(int num, ScrollController _courseController) {
    print(num);
    state = num;
    _scrollDown(_courseController);
  }

  void _scrollDown(ScrollController _courseController) {
    _courseController.jumpTo(
      state.toDouble() * 110,
    );
  }

  int selectedCorse() {
    return state;
  }
}

final HomePageCoursesProvider =
    StateNotifierProvider<HomePageCoursesListenerProvider, int>(
        (ref) => HomePageCoursesListenerProvider());
final HomePageAssignmentProvider =
    StateNotifierProvider<HomePageAssigmentListenerProvider, int>(
        (ref) => HomePageAssigmentListenerProvider());

final HomePagesegmentProvider =
    StateNotifierProvider<HpomePageSegmentListenerProvider, int>(
        (ref) => HpomePageSegmentListenerProvider());

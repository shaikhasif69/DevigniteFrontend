import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volume_watcher/volume_watcher.dart';

class LearningPageListenerProvider extends StateNotifier<int> {
  LearningPageListenerProvider() : super(0);
  void selectSub(int num) {
    print(num);
    state = num;
  }

  int selectedSubIs() {
    return state;
  }
}

final LearningPageProvider =
    StateNotifierProvider<LearningPageListenerProvider, int>(
        (ref) => LearningPageListenerProvider());

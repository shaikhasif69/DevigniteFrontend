import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volume_watcher/volume_watcher.dart';

class BottomNavigationListenerProvider extends StateNotifier<int> {
  BottomNavigationListenerProvider() : super(0);
  void selectSub(int num) {
    print(num);
    state = num;
  }

  int selectedSubIs() {
    return state;
  }
}

final BottomNaigationProvider =
    StateNotifierProvider<BottomNavigationListenerProvider, int>(
        (ref) => BottomNavigationListenerProvider());

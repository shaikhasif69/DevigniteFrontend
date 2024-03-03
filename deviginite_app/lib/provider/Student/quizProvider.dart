import 'package:deviginite_app/services/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volume_watcher/volume_watcher.dart';

class QuizListenerProvider extends StateNotifier<List<String>> {
  QuizListenerProvider() : super([]);
  Future<void> fetchData(bool isAdult) async {
    state = await QuizServices.getQuiz(isAdult);
  }

  List<String> getData() {
    return state;
  }
}

final QuizProvider = StateNotifierProvider<QuizListenerProvider, List<String>>(
    (ref) => QuizListenerProvider());

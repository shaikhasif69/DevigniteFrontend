import 'package:deviginite_app/provider/flutterTts2provider.dart';
import 'package:deviginite_app/services/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';

class FlutterTTSProviderNotifer extends StateNotifier<String> {
  FlutterTTSProviderNotifer({required this.ref}) : super("");
  dynamic ref;
  late AnimationController controller;
  late Function micOff;
  late Function updateBHome;
  late Function micSwitchFunOn;
  int containerWidth = 0;
  double containerHeight = 0;
  late Function micSwitchFunOf;
  final FlutterTts ftts = FlutterTts();
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = "";
  String data = "";
  bool micSwitch = false;
  double roboWidth = 400;
  bool micOn = false;
  double roboheight = 400;
  bool fetchingResult = false;
  bool solution = false;
  String solutionString = "";
  bool listenModeBool = false;
  void listenMode() {
    roboWidth = 200;
    roboheight = 200;
    // micSwitch = true;
    micSwitchFunOn();
    state = "s";
  }

  void micOFFFun(Function fun) {
    micOff = fun;
  }

  void micSwitchFunnOn(Function fun) {
    micSwitchFunOn = fun;
  }

  void micSwitchFunnOf(Function fun) {
    micSwitchFunOf = fun;
  }

  void AiInit() {
    solution = false;
    listenModeBool = false;
    roboWidth = 400;
    roboheight = 400;
    print("init");
    state = "";
  }

  void initSpeech() async {
    listenForPermissions();
    if (!speechEnabled) {
      speechEnabled = await speechToText.initialize();
    }
  }

  void stopListening() async {
    listenModeBool = false;
    micOn = false;
    micOff();
    // micSwitch = false;
    // micSwitchFunOf();
    state = "2";
    await ftts.stop();

    await speechToText.stop();

    lastWords = "";
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    print("result: " + lastWords);
    solution = false;
    micOff();
    micOn = false;
    listenModeBool = false;
    lastWords = result.recognizedWords;
    print("result1: " + lastWords);
    data = lastWords;
    state = "lastwords";
    fetchingResult = true;
    controller.repeat();

    String res = await QuizServices.fetchMessage(lastWords);
    controller.stop();
    fetchingResult = false;

    print(res);
    if (res != "fail") {
      solution = true;
      solutionString = res;
    } else {
      solutionString = "Some Internal Error Occured Please Try again later";
    }
    ftts.speak(solutionString);
    state = "result";
  }

  void startListening() async {
    await ftts.stop();
    data = "listening...";
    await ftts.speak("listening...");
    listenModeBool = true;
    lastWords = '';
    state = "0";
    await speechToText.listen(
      onResult: onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    if (lastWords == "") {
      micOff();
    }
    state = "lsi";
    print(lastWords);
  }

  // void VoiceAssistant() async {
  //   Future.delayed(Duration(seconds: 3), () {
  //     lastWords = "";
  //     startListening();
  //   });
  // }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  void speak(string) {
    data = string;
    ftts.speak(string);
  }

  void onDoubleTap(context) async {
    if (ref.read(FLutterTTSProvider2.notifier).container2Height == 0) {
      Vibration.vibrate(duration: 300);

      // setState(() {
      if (containerHeight == 0) {
        containerHeight = MediaQuery.of(context).size.height * 0.66;
        // micSwitchFunOn();
        AiInit();
        welcome();
        // ref.read(FLutterTTSProvider.notifier).listenMode();
      } else {
        micOn = false;
        containerHeight = 0.0;
        stopListening();
        print("killed");
        micSwitchFunOf();
      }
      updateBHome();
      // });
      // openVoiceModal(context);
    }
  }

  void welcome() async {
    data = "Welcome To SAP Voice Assistive AI.... How Can I Help You?";
    await ftts.awaitSpeakCompletion(true);
    await ftts.speak(data).whenComplete(() {
      listenMode();
    });
    // await ftts.awaitSpeakCompletion(false);
  }
}

final FLutterTTSProvider =
    StateNotifierProvider<FlutterTTSProviderNotifer, String>(
        (ref) => FlutterTTSProviderNotifer(ref: ref));

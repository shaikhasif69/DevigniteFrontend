import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:deviginite_app/services/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';

class FlutterTTS2ProviderNotifer extends StateNotifier<String> {
  FlutterTTS2ProviderNotifer(this.ref) : super("");
  dynamic ref;
  late Function routeTo;
  final FlutterTts ftts = FlutterTts();
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = "";
  bool micSwitch = false;
  double container2Height = 0;
  bool micOn = false;
  String data = "";
  late Function updateBHome;
  double roboHeight = 400;
  double roboWidth = 400;
  bool listenMood = false;
  bool fecthMood = false;
  bool solution = false;
  void initSpeech() async {
    listenForPermissions();
    if (!speechEnabled) {
      speechEnabled = await speechToText.initialize();
    }
  }

  void assignRouteFun(Function fun) {
    routeTo = fun;
  }

  void listenMode(string) async {
    await ftts.awaitSpeakCompletion(true);
    await ftts.speak(string);
    micOn = true;
    roboHeight = 250;
    roboWidth = 250;
    state = "changed";

    startListening();
  }

  void stopListening() async {
    // micSwitch = false;

    // micSwitchFunOf();
    micOn = false;

    listenMood = false;

    await ftts.stop();

    await speechToText.stop();
    state = "2";
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    lastWords = result.recognizedWords;
    listenMood = false;
    data = lastWords;
    fecthMood = true;
    state = "lastwords";
    print("recult is :" + lastWords);
    String res = await QuizServices.getRoute(lastWords);
    fecthMood = false;
    print(res);
    if (res != "fail") {
      speak("Heading to " + res);
      if (res == '"/profile"') {
        routeTo(2);
      } else if (res == '"/home"') {
        routeTo(0);
      } else if (res == '"/learnings"') {
        routeTo(1);
      }
      micOn = false;
      micSwitch = false;
    } else {
      listenMode("Failed Please try again");
    }
    listenMood = false;

    state = "result";
  }

  void startListening() async {
    listenMood = true;
    state = "998";
    await ftts.stop();
    data = "listening...";
    await ftts.speak("listening...");

    lastWords = '';
    state = "0";
    await speechToText.listen(
      onResult: onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenOptions:
          SpeechListenOptions(autoPunctuation: true, cancelOnError: true),
      listenMode: ListenMode.confirmation,
    );

    if (lastWords == "") {
      print("sss");
    } else {}
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

  void onLongPress(context) {
    print("s");
    if (ref.read(FLutterTTSProvider.notifier).containerHeight == 0) {
      Vibration.vibrate(duration: 500);
      if (container2Height == 0) {
        // setState(() {
        micSwitch = true;
        micOn = true;
        container2Height = MediaQuery.of(context).size.height * 0.66;
        listenMode("Where Do You Want to Navigate");
        // });
      } else {
        // setState(() {
        micSwitch = false;
        stopListening();
        container2Height = 0.0;
        // });
      }
      updateBHome();
    }
    ;
  }

  void welcome() async {
    data = "Welcome To SAP Voice Assistive AI.... How Can I Help You?";
    await ftts.awaitSpeakCompletion(true);
    await ftts.speak(data).whenComplete(() {});
    // await ftts.awaitSpeakCompletion(false);
  }
}

final FLutterTTSProvider2 =
    StateNotifierProvider<FlutterTTS2ProviderNotifer, String>(
        (ref) => FlutterTTS2ProviderNotifer(ref));

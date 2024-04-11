import 'package:deviginite_app/services/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FlutterTTSProvider extends StateNotifier<String> {
  FlutterTTSProvider() : super("");

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  void _initSpeech() async {
    listenForPermissions();
    if (!_speechEnabled) {
      _speechEnabled = await _speechToText.initialize();
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    _lastWords = "$_lastWords${result.recognizedWords} ";

    print("hhhhh" + _lastWords);

    String res = await QuizServices.fetchMessage(_lastWords);
    print(res);
    if (res != "fail") {
    } else {}
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );

    print(_lastWords);
  }

  void VoiceAssistant() async {
    Future.delayed(Duration(seconds: 3), () {
      _lastWords = "";
      _startListening();
    });
  }

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
}

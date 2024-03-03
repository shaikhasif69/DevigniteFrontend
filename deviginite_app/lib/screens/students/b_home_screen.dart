import 'dart:async';
import 'dart:async';
import 'dart:math';
import 'dart:developer' as log;
import 'package:deviginite_app/Fragments.dart/Wave.dart';
import 'package:deviginite_app/model/quiz.dart';
import 'package:deviginite_app/provider/bottomNavigationprovider.dart';
import 'package:deviginite_app/services/quiz.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:deviginite_app/Widgets/coursesCard.dart';
import 'package:deviginite_app/model/subject.dart';
import 'package:deviginite_app/provider/Student/HomePageProvider.dart';
import 'package:deviginite_app/provider/Student/learningPage.dart';
import 'package:deviginite_app/routers/NamedRoutes.dart';
import 'package:deviginite_app/tabs/premium_course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:terna_frontend/models/Campaign.dart';
// import 'package:terna_frontend/services/Campaigns.dart';
// import 'package:terna_frontend/tabs/search_bar_widget.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';

import '../../utils/app_banner.dart';
import '../../utils/FeatureSubjectCards.dart';

// import '../tabs/event_featured_item.dart';
// import '../tabs/upcoming_events.dart';
// import '../utils/app_banner.dart';
// import 'campaign_details_page.dart';

class BHomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<BHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<BHomeScreen> {
  SiriWaveformController controller =
      IOS7SiriWaveformController(color: Colors.pink);
  final ScrollController _assignmentController = ScrollController();
  final ScrollController _courseController = ScrollController();
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  String TextData = "";

  /// Each time to start a speech recognition session
  _startListening() async {
    print("ss");
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );

    print(_lastWords);

    setState(() {});
  }

  late Map<dynamic, dynamic> AIData;

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    log.log(_lastWords);
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _textController.text = _lastWords;

      print("hhhhh" + _lastWords);
    });
    AIData = await QuizServices.fetchMessage(_lastWords);
    print("data from serevr");
    print(AIData);
    if (AIData['status'] == "success") {
      if (AIData['text'][0] == '/') {
        if (AIData['text'] == "/home") {
          print("hommmm");
          ref.watch(BottomNaigationProvider.notifier).selectSub(0);
        } else if (AIData['text'] == "/learnings") {
          ref.watch(BottomNaigationProvider.notifier).selectSub(1);
        } else if (AIData['text'] == "/profile") {
          ref.watch(BottomNaigationProvider.notifier).selectSub(2);
        }

        setState(() {
          TextData = "";
          voiceAssistent = false;
        });
      } else {
        setState(() {
          TextData = AIData['text'];
        });
        flutterTts.speak("Answere is.." + AIData['text']);
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            TextData = "";
            voiceAssistent = false;
          });
        });
      }
    } else {
      flutterTts.speak("Please try again.");
      setState(() {
        TextData = "";
        voiceAssistent = false;
      });
    }
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

  void VoiceAssistant() async {
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.4);
    flutterTts
        .speak("Welcome to SAP Assistant...  let me Know your Querrys?..");
    Future.delayed(Duration(seconds: 3), () {
      // Code to be executed after the delay
      _lastWords = "";
      _startListening();
    });

    // await QuizServices.fetchMessage();
    // Timer(Duration(seconds: 10), () async {
    //   setState(() {
    //     voiceAssistent = false;
    //   });
    // });
  }

  // Future<dynamic> courses =

  // Future<dynamic> campaigns = Campaigns.getLatest5Campaigns();
  // Future<dynamic> upcomingCampaigns = Campaigns.getLatest5UpcomingCampaigns();
  // Future<dynamic> nearbyCampaigns = Campaigns.getNearByCampaigns(_currentPosition!.latitude, );

  @override
  void dispose() {
    super.dispose();
  }

  int PageSegmentAccessed = 0;

  double ballSize = 20.0;
  double step = 10.0;
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.horizontalAndVertical;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
    // TODO: implement initState
    // eventController.getAllEventsForUser();
    super.initState();
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  final TextEditingController _textController = TextEditingController();

  bool voiceAssistent = false;
  @override
  Widget build(BuildContext context) {
    ref.watch(HomePagesegmentProvider);
    ref.watch(HomePageAssignmentProvider);
    int seletedAssignment =
        ref.watch(HomePageAssignmentProvider.notifier).selectedAssignment();
    int seletedCourse =
        ref.watch(HomePageCoursesProvider.notifier).selectedCorse();
    int selectedSeg =
        ref.read(HomePagesegmentProvider.notifier).selectedSegment();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 213, 235),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: voiceAssistent ? 0.3 : 1,
              duration: Duration(milliseconds: 200),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      // SvgPicture.asset("assets/images/app_icon_color.svg"),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // padded(locationWidget()),
                      // const SizedBox(
                      //   height: 15,
                      // ),

                      padded(MyAppBanner()),
                      // const SizedBox(
                      //   height: 25,
                      // ),

                      FeaturedSubjectCards(),

                      padded(Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: selectedSeg == 2
                                ? Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer)
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            Text(
                              "New Assignment",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height:
                            195, // Adjust the height according to your design
                        child: ListView.builder(
                          controller: _assignmentController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              5, // Change this to the number of items you want to display
                          itemBuilder: (context, index) {
                            return PremiumCourseCard(
                              selected: (seletedAssignment - 1) == index
                                  ? true
                                  : false,
                            );
                          },
                        ),
                      ),
                      padded(Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: selectedSeg == 3
                                ? Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer)
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            Text(
                              "New Courses",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height:
                            100, // Adjust the height according to your design
                        child: ListView.builder(
                          controller: _courseController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              5, // Change this to the number of items you want to display
                          itemBuilder: (context, index) {
                            return CoursesCard(
                              isSeleted:
                                  (seletedCourse - 1) == index ? true : false,
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 150,
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      // getHorizontalItemSlider(groceries),
                      // SizedBox(
                      //   height: 15,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // top: 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: voiceAssistent
                    ? Container(
                        height: 400,
                        child: Column(
                          children: [
                            Text(
                              _lastWords,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              TextData,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SiriWaveform.ios7(
                              controller:
                                  controller as IOS7SiriWaveformController,
                              options: const IOS7SiriWaveformOptions(
                                height: kIsWeb ? 300 : 180,
                                width: kIsWeb ? 600 : 360,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Joystick(
                        period: Duration(milliseconds: 400),
                        stick: ElevatedButton(
                          child: Text(""),
                          onPressed: () {},
                          onLongPress: () {
                            if (selectedSeg == 1) {
                              GoRouter.of(context)
                                  .pushNamed(StudentsRoutes.quiz);
                            } else if (selectedSeg <= 0) {
                              setState(() {
                                voiceAssistent = true;
                              });

                              VoiceAssistant();
                            }
                            Vibration.vibrate(duration: 300);
                          },
                        ),
                        mode: _joystickMode,
                        listener: (details) {
                          Vibration.vibrate(duration: 100);
                          int selectedSeg = ref
                              .read(HomePagesegmentProvider.notifier)
                              .selectedSegment();

                          if (selectedSeg <= 1) {
                            ref
                                .read(HomePagesegmentProvider.notifier)
                                .selectSeg(selectedSeg + 1);
                          } else if (selectedSeg <= 2) {
                            if (selectedSeg < 2) {
                              ref
                                  .read(HomePagesegmentProvider.notifier)
                                  .selectSeg(selectedSeg + 1);
                            }
                            int data = ref
                                .watch(HomePageAssignmentProvider.notifier)
                                .selectedAssignment();
                            if (data <= 4) {
                              ref
                                  .watch(HomePageAssignmentProvider.notifier)
                                  .selectAssignment(
                                      data + 1, _assignmentController);
                            } else {
                              ref
                                  .watch(HomePageAssignmentProvider.notifier)
                                  .selectAssignment(0, _assignmentController);
                              ref
                                  .read(HomePagesegmentProvider.notifier)
                                  .selectSeg(selectedSeg + 1);
                            }
                          } else if (selectedSeg == 3) {
                            int data = ref
                                .watch(HomePageCoursesProvider.notifier)
                                .selectedCorse();
                            if (data <= 4) {
                              ref
                                  .watch(HomePageCoursesProvider.notifier)
                                  .selectCourse(data + 1, _courseController);
                            } else {
                              ref
                                  .watch(HomePageCoursesProvider.notifier)
                                  .selectCourse(0, _courseController);
                              ref
                                  .read(HomePagesegmentProvider.notifier)
                                  .selectSeg(-1);
                            }
                          }
                          if (ref
                                  .watch(HomePagesegmentProvider.notifier)
                                  .selectedSegment() >
                              0)
                            flutterTts.speak(homePageList[ref
                                    .watch(HomePagesegmentProvider.notifier)
                                    .selectedSegment() -
                                1]['name']);

                          ref.read(LearningPageProvider.notifier).selectSub(0);
                          print("x is: " + details.x.toString());
                          print("y is: " + details.y.toString());
                          _x = _x + step * details.x;
                          _y = _y + step * details.y;
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  // Widget getHorizontalItemSlider(List<Events> items) {
  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/images/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Mumbai, Byculla!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

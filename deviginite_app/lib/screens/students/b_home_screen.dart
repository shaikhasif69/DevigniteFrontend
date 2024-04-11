import 'dart:developer' as log;
import 'package:deviginite_app/Widgets/Navigation.dart';
import 'package:deviginite_app/Widgets/voiceAi.dart';
import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:deviginite_app/provider/flutterTts2provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:lottie/lottie.dart';
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

class _HomeScreenState extends ConsumerState<BHomeScreen>
    with TickerProviderStateMixin {
  // SiriWaveformController controller =
  //     IOS7SiriWaveformController(color: Colors.pink);

  final ScrollController _assignmentController = ScrollController();
  final ScrollController _courseController = ScrollController();

  String TextData = "";

  @override
  void dispose() {
    super.dispose();
  }

  int PageSegmentAccessed = 0;
  int containerWidth = 0;
  double containerHeight = 0;
  double container2Height = 0;
  double ballSize = 10.0;
  double step = 10.0;
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.horizontalAndVertical;
  // bool micSwitch = false;
  // bool micOn = false;
  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    ref.read(FLutterTTSProvider.notifier).initSpeech();
    ref.read(FLutterTTSProvider2.notifier).initSpeech();
    ref.read(FLutterTTSProvider.notifier).micOFFFun(micOffFun);
    ref.read(FLutterTTSProvider.notifier).micSwitchFunnOn(micSwitchFunOn);
    ref.read(FLutterTTSProvider.notifier).micSwitchFunnOf(micSwitchFunOf);
    super.initState();
  }

  void micSwitchFunOn() {
    ref.read(FLutterTTSProvider.notifier).micSwitch = true;
    setState(() {});
  }

  void micSwitchFunOf() {
    ref.read(FLutterTTSProvider.notifier).micSwitch = false;
    print(ref.read(FLutterTTSProvider.notifier).micSwitch);
    ref.read(FLutterTTSProvider.notifier).micOn = false;
    setState(() {
      print("off is ");
    });
  }

  void setContainerHeight2() {
    setState(() {
      container2Height = 0;
    });
  }

  void micOffFun() {
    setState(() {
      ref.read(FLutterTTSProvider.notifier).micOn = false;
    });
  }

  final TextEditingController _textController = TextEditingController();

  bool voiceAssistent = false;
  @override
  Widget build(BuildContext context) {
    if (containerHeight == 0) {
      ref.read(FLutterTTSProvider.notifier).micSwitch = false;
    }
    ref.watch(HomePagesegmentProvider);
    ref.watch(HomePageAssignmentProvider);
    int seletedAssignment =
        ref.watch(HomePageAssignmentProvider.notifier).selectedAssignment();
    int seletedCourse =
        ref.watch(HomePageCoursesProvider.notifier).selectedCorse();
    int selectedSeg =
        ref.read(HomePagesegmentProvider.notifier).selectedSegment();

    print("mic: " + ref.read(FLutterTTSProvider.notifier).micSwitch.toString());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 213, 235),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      height: 195, // Adjust the height according to your design
                      child: ListView.builder(
                        controller: _assignmentController,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            5, // Change this to the number of items you want to display
                        itemBuilder: (context, index) {
                          return PremiumCourseCard(
                            selected:
                                (seletedAssignment - 1) == index ? true : false,
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
                      height: 100, // Adjust the height according to your design
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
            AnimatedContainer(
              height: containerHeight,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 180),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 75, 112, 139),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: VoiceAi(),
            ),
            AnimatedContainer(
              height: container2Height,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 180),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 75, 112, 139),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: NavigateAi(),
            ),
            Positioned(
              // top: 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Joystick(
                  period: Duration(seconds: 400),
                  stick: InkWell(
                    onTap: () {
                      if (selectedSeg == 1) {
                        GoRouter.of(context).pushNamed(StudentsRoutes.quiz);
                      } else if (selectedSeg <= 0) {
                        // VoiceAssistant();
                      }
                    },
                    onLongPress: containerHeight == 0
                        ? () {
                            Vibration.vibrate(duration: 500);
                            if (container2Height == 0) {
                              setState(() {
                                ref
                                    .read(FLutterTTSProvider2.notifier)
                                    .micSwitch = true;
                                ref.read(FLutterTTSProvider2.notifier).micOn =
                                    true;
                                container2Height =
                                    MediaQuery.of(context).size.height * 0.66;
                                ref
                                    .read(FLutterTTSProvider2.notifier)
                                    .listenMode("Where Do You Want to head");
                              });
                            } else {
                              setState(() {
                                ref
                                    .read(FLutterTTSProvider2.notifier)
                                    .micSwitch = false;
                                ref
                                    .read(FLutterTTSProvider2.notifier)
                                    .stopListening();
                                container2Height = 0;
                              });
                            }
                          }
                        : null,
                    onDoubleTap: container2Height == 0
                        ? () async {
                            Vibration.vibrate(duration: 300);

                            setState(() {
                              if (containerHeight == 0) {
                                containerHeight =
                                    MediaQuery.of(context).size.height * 0.66;
                                // micSwitchFunOn();
                                ref.read(FLutterTTSProvider.notifier).AiInit();
                                ref.read(FLutterTTSProvider.notifier).welcome();
                                // ref.read(FLutterTTSProvider.notifier).listenMode();
                              } else {
                                ref.read(FLutterTTSProvider.notifier).micOn =
                                    false;
                                containerHeight = 0;
                                ref
                                    .read(FLutterTTSProvider.notifier)
                                    .stopListening();
                                print("killed");
                                micSwitchFunOf();
                              }
                            });
                            // openVoiceModal(context);
                          }
                        : null,
                    child: ref.read(FLutterTTSProvider.notifier).micSwitch ||
                            ref.read(FLutterTTSProvider2.notifier).micSwitch
                        ? InkWell(
                            focusColor: Colors.transparent,
                            onTap: () {
                              Vibration.vibrate(duration: 100);
                              setState(() {
                                if (containerHeight != 0) {
                                  if (ref
                                      .read(FLutterTTSProvider.notifier)
                                      .micSwitch) {
                                    if (ref
                                        .read(FLutterTTSProvider.notifier)
                                        .micOn) {
                                      ref
                                          .read(FLutterTTSProvider.notifier)
                                          .stopListening();
                                      ref
                                          .read(FLutterTTSProvider.notifier)
                                          .micOn = false;
                                    } else {
                                      ref
                                          .read(FLutterTTSProvider.notifier)
                                          .micOn = true;

                                      ref
                                          .read(FLutterTTSProvider.notifier)
                                          .startListening();
                                    }
                                  } else {}
                                } else if (container2Height != 0) {
                                  if (!ref
                                      .read(FLutterTTSProvider2.notifier)
                                      .micOn) {
                                    setState(() {
                                      ref
                                          .read(FLutterTTSProvider2.notifier)
                                          .listenMode("");
                                    });
                                  } else {
                                    setState(() {
                                      ref
                                          .read(FLutterTTSProvider2.notifier)
                                          .stopListening();
                                    });
                                  }
                                }
                              });
                            },
                            child: LottieBuilder.asset(
                                height:
                                    ref.read(FLutterTTSProvider.notifier).micOn
                                        ? 170
                                        : 120,
                                animate: ref
                                        .read(FLutterTTSProvider.notifier)
                                        .micOn ||
                                    ref
                                        .read(FLutterTTSProvider2.notifier)
                                        .micOn,
                                'assets/images/Animation - 1712589400505.json'),
                          )
                        : ElevatedButton(
                            child: Text(""),
                            onPressed: () {},
                          ),
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
                            .selectAssignment(data + 1, _assignmentController);
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
                        0) ref.read(LearningPageProvider.notifier).selectSub(0);
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

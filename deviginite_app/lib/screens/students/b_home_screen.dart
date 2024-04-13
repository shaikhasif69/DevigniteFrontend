import 'dart:developer' as log;
import 'package:deviginite_app/Widgets/Assignment.dart';
import 'package:deviginite_app/Widgets/Navigation.dart';
import 'package:deviginite_app/Widgets/voiceAi.dart';
import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:deviginite_app/provider/flutterTts2provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:deviginite_app/Widgets/coursesCard.dart';
import 'package:deviginite_app/provider/Student/HomePageProvider.dart';
import 'package:deviginite_app/provider/Student/learningPage.dart';
import 'package:deviginite_app/routers/NamedRoutes.dart';
import 'package:deviginite_app/tabs/premium_course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import '../../utils/app_banner.dart';
import '../../utils/FeatureSubjectCards.dart';

class BHomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<BHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<BHomeScreen> {
  final ScrollController _courseController = ScrollController();

  String TextData = "";

  @override
  void dispose() {
    super.dispose();
  }

  int PageSegmentAccessed = 0;

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
    ref.read(FLutterTTSProvider2.notifier).updateBHome = update;
    ref.read(HomePagesegmentProvider.notifier).update = update;
    ref.read(FLutterTTSProvider.notifier).updateBHome = update;
    ref.read(FLutterTTSProvider.notifier).micSwitchFunnOf(micSwitchFunOf);
    super.initState();
  }

  void micSwitchFunOn() {
    ref.read(FLutterTTSProvider.notifier).micSwitch = true;
    setState(() {});
  }

  void micSwitchFunOf() {
    ref.read(FLutterTTSProvider.notifier).micSwitch = false;

    ref.read(FLutterTTSProvider.notifier).micOn = false;
    setState(() {});
  }

  void setContainerHeight2() {
    setState(() {
      ref.read(FLutterTTSProvider2.notifier).container2Height = 0;
    });
  }

  void micOffFun() {
    setState(() {
      ref.read(FLutterTTSProvider.notifier).micOn = false;
    });
  }

  void update() {
    setState(() {});
  }

  final TextEditingController _textController = TextEditingController();

  bool voiceAssistent = false;
  @override
  Widget build(BuildContext context) {
    if (ref.read(FLutterTTSProvider.notifier).containerHeight == 0) {
      ref.read(FLutterTTSProvider.notifier).micSwitch = false;
    }

    int selectedIndex = ref.read(HomePagesegmentProvider.notifier).SelectedInt;
    return Scaffold(
      backgroundColor: ref.read(HomePagesegmentProvider.notifier).bg,
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

                    const SizedBox(
                      height: 10,
                    ),
                    AllAssignmentList(),
                    // // padded(Container(
                    // //   padding: EdgeInsets.all(8),
                    // //   decoration: BoxDecoration(
                    // //       border: selectedSeg == 3
                    // //           ? Border.all(
                    // //               width: 4,
                    // //               color: Theme.of(context)
                    // //                   .colorScheme
                    // //                   .primaryContainer)
                    // //           : null,
                    // //       borderRadius: BorderRadius.circular(10)),
                    // //   child: const Row(
                    // //     children: [
                    // //       Text(
                    // //         "New Courses",
                    // //         style: TextStyle(
                    // //             fontSize: 20, fontWeight: FontWeight.bold),
                    // //       ),
                    // //     ],
                    // //   ),
                    // )),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 100, // Adjust the height according to your design
                    //   child: ListView.builder(
                    //     controller: _courseController,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount:
                    //         5, // Change this to the number of items you want to display
                    //     itemBuilder: (context, index) {
                    //       return CoursesCard(
                    //         isSeleted:
                    //             (seletedCourse - 1) == index ? true : false,
                    //       );
                    //     },
                    //   ),
                    // ),

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
              height: ref.read(FLutterTTSProvider.notifier).containerHeight,
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
              height: ref.read(FLutterTTSProvider2.notifier).container2Height,
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
                  period: Duration(milliseconds: 200),
                  stick: joystickChild(),
                  mode: _joystickMode,
                  listener: (details) {
                    Map<String, dynamic> data1 =
                        ref.read(HomePagesegmentProvider);
                    Vibration.vibrate(duration: 100);
                    _x = details.x;
                    _y = details.y;
                    if (_x == 0.0 && _y < 0.0) {
                      print("direction is: UP");
                      print(ref
                          .read(HomePagesegmentProvider.notifier)
                          .selectedSeg);
                      if (ref
                              .read(HomePagesegmentProvider.notifier)
                              .selectedSeg ==
                          "quiz") {
                        ref
                            .read(HomePagesegmentProvider.notifier)
                            .selectSeg("assignment");
                      } else if (ref
                              .read(HomePagesegmentProvider.notifier)
                              .selectedSeg ==
                          "assignment") {
                        ref
                            .read(HomePagesegmentProvider.notifier)
                            .selectSeg("quiz");
                      }
                      ref.read(FLutterTTSProvider.notifier).ftts.speak(ref
                          .read(HomePagesegmentProvider.notifier)
                          .selectedSeg);
                    } else if (_x > 0.0 && _y == 0.0) {
                      ref.read(HomePagesegmentProvider.notifier).selectIndex(ref
                              .read(HomePagesegmentProvider.notifier)
                              .SelectedInt +
                          1);

                      ;
                    } else if (_x < 0 && _y == 0) {
                      ref.read(HomePagesegmentProvider.notifier).selectIndex(ref
                              .read(HomePagesegmentProvider.notifier)
                              .SelectedInt -
                          1);

                      print("Direction is : left");
                    } else if (_x == 0 && _y > 0) {
                      if (ref
                              .read(HomePagesegmentProvider.notifier)
                              .selectedSeg ==
                          "quiz") {
                        ref
                            .read(HomePagesegmentProvider.notifier)
                            .selectSeg("assignment");
                      } else if (ref
                              .read(HomePagesegmentProvider.notifier)
                              .selectedSeg ==
                          "assignment") {
                        ref
                            .read(HomePagesegmentProvider.notifier)
                            .selectSeg("quiz");
                      }
                      ref.read(FLutterTTSProvider.notifier).ftts.speak(ref
                          .read(HomePagesegmentProvider.notifier)
                          .selectedSeg);
                      print("direction is: Down");
                    }
                    ;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget joystickChild() {
    return InkWell(
      onTap: () {},
      onLongPress: () {
        ref.read(FLutterTTSProvider2.notifier).onLongPress(context);
      },
      onDoubleTap: () {
        ref.read(FLutterTTSProvider.notifier).onDoubleTap(context);
      },
      child: ref.read(FLutterTTSProvider.notifier).micSwitch ||
              ref.read(FLutterTTSProvider2.notifier).micSwitch
          ? InkWell(
              focusColor: Colors.transparent,
              onTap: () {
                Vibration.vibrate(duration: 100);
                setState(() {
                  if (ref.read(FLutterTTSProvider.notifier).containerHeight !=
                      0) {
                    if (ref.read(FLutterTTSProvider.notifier).micSwitch) {
                      if (ref.read(FLutterTTSProvider.notifier).micOn) {
                        ref.read(FLutterTTSProvider.notifier).stopListening();
                        ref.read(FLutterTTSProvider.notifier).micOn = false;
                      } else {
                        ref.read(FLutterTTSProvider.notifier).micOn = true;

                        ref.read(FLutterTTSProvider.notifier).startListening();
                      }
                    } else {}
                  } else if (ref
                          .read(FLutterTTSProvider2.notifier)
                          .container2Height !=
                      0) {
                    if (!ref.read(FLutterTTSProvider2.notifier).micOn) {
                      setState(() {
                        ref.read(FLutterTTSProvider2.notifier).listenMode("");
                      });
                    } else {
                      setState(() {
                        ref.read(FLutterTTSProvider2.notifier).stopListening();
                      });
                    }
                  }
                });
              },
              child: LottieBuilder.asset(
                  height:
                      ref.read(FLutterTTSProvider.notifier).micOn ? 170 : 120,
                  animate: ref.read(FLutterTTSProvider.notifier).micOn ||
                      ref.read(FLutterTTSProvider2.notifier).micOn,
                  'assets/images/Animation - 1712589400505.json'),
            )
          : ElevatedButton(
              child: Text(""),
              onPressed: () {
                Vibration.vibrate(duration: 100);
                if (ref.read(HomePagesegmentProvider.notifier).selectedSeg ==
                    "quiz") {
                  GoRouter.of(context).pushNamed(StudentsRoutes.quiz);
                }
              },
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

import 'package:deviginite_app/tabs/premium_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:terna_frontend/models/Campaign.dart';
// import 'package:terna_frontend/services/Campaigns.dart';
// import 'package:terna_frontend/tabs/search_bar_widget.dart';
import 'package:deviginite_app/utils/app_constants.dart';

import '../../utils/app_banner.dart';
import '../../utils/FeatureSubjectCards.dart';

// import '../tabs/event_featured_item.dart';
// import '../tabs/upcoming_events.dart';
// import '../utils/app_banner.dart';
// import 'campaign_details_page.dart';

class BHomeScreen extends StatefulWidget {
  @override
  State<BHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BHomeScreen> {
  // final DetailPage args = Get.arguments;
  String? _currentAddress;
  Position? _currentPosition;

  // Future<dynamic> courses =

  // Future<dynamic> campaigns = Campaigns.getLatest5Campaigns();
  // Future<dynamic> upcomingCampaigns = Campaigns.getLatest5UpcomingCampaigns();
  // Future<dynamic> nearbyCampaigns = Campaigns.getNearByCampaigns(_currentPosition!.latitude, );

  @override
  void dispose() {
    // TODO: implement dispose
    // eventController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // eventController.getAllEventsForUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appSecondaryBack,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SvgPicture.asset("assets/images/app_icon_color.svg"),
                  const SizedBox(
                    height: 5,
                  ),
                  padded(locationWidget()),
                  const SizedBox(
                    height: 15,
                  ),
                  // padded(SearchBarWidget()),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  padded(MyAppBanner()),
                  const SizedBox(
                    height: 25,
                  ),
                  // padded(
                  //   Row(
                  //     children: [
                  //       const Text(
                  //         "Campaigns!",
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //       const Spacer(),
                  //       TextButton(
                  //         onPressed: () {
                  //           Get.toNamed("/getAllCampaigns");
                  //         },
                  //         child: const Text(
                  //           "See All",
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.bold,
                  //             color: Color.fromARGB(255, 247, 110, 110),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  Container(
                    height: 120,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        FeaturedSubjectCards(
                          eventFeatureItems[0],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FeaturedSubjectCards(
                          eventFeatureItems[1],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 105,
                  //   child: FutureBuilder(
                  //     future: campaigns,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return const CircularProgressIndicator();
                  //       } else if (snapshot.hasData) {
                  //         final posts = snapshot.data!;

                  //         if (snapshot.data.length <= 0) {
                  //           return const Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "No data found",
                  //                 style: TextStyle(
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.w400,
                  //                 ),
                  //               )
                  //             ],
                  //           );
                  //         }

                  //         return ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: snapshot.data.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return GestureDetector(
                  //               onTap: () async {
                  //                 final SharedPreferences prefs =
                  //                     await SharedPreferences.getInstance();

                  //                 String? userId = prefs.getString("userId");

                  //                 Get.to(DetailPage(
                  //                     data: snapshot.data[index],
                  //                     userId: userId!));
                  //               },
                  //               child: EventFeatureCards(
                  //                 snapshot.data[index],
                  //                 color: AppConstants.tAccentColor,
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       } else {
                  //         return const Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [Text("No data found")],
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Recomended Course!")),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 195, // Adjust the height according to your design
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          5, // Change this to the number of items you want to display
                      itemBuilder: (context, index) {
                        return const PremiumCourseCard();
                      },
                    ),
                  ),

                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.3,
                  //   child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: FutureBuilder(
                  //         future: nearbyCampaigns,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return const CircularProgressIndicator();
                  //           } else if (snapshot.hasData) {
                  //             final posts = snapshot.data!;

                  //             if (snapshot.data.length <= 0) {
                  //               return const Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "No data found",
                  //                     style: TextStyle(
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.w400,
                  //                     ),
                  //                   )
                  //                 ],
                  //               );
                  //             }

                  //             return ListView.builder(
                  //               scrollDirection: Axis.vertical,
                  //               itemCount: snapshot.data.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return UpComingEvents(
                  //                   eventName: snapshot.data[index]["title"],
                  //                   eventSubTitle: snapshot.data[index]
                  //                       ["description"],
                  //                   eventImage: snapshot.data[index]
                  //                       ["attachment"],
                  //                   eventStartDate: snapshot.data[index]
                  //                       ["startDate"],
                  //                 );
                  //               },
                  //             );
                  //           } else {
                  //             return const Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [Text("No data found")],
                  //             );
                  //           }
                  //         },
                  //       )

                  //       // child: ListView.builder(
                  //       //     itemCount: 4,
                  //       //     itemBuilder: (context, index) {
                  //       //       return UpComingEvents(
                  //       //         eventName: upcomingevent[index][0],
                  //       //         eventSubTitle: upcomingevent[index][1],
                  //       //         eventImage: upcomingevent[index][2],
                  //       //         eventStartDate: upcomingevent[index][3],
                  //       //       );
                  //       //     }),
                  //       ),
                  // ),
                  const SizedBox(
                    height: 150,
                  ),
                  // padded(subTitle("Best Selling")),
                  // getHorizontalItemSlider(firstEvent),
                  padded(
                    Row(
                      children: [
                        const Text(
                          "Premium Course!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/getAllUpcomingCampaigns");
                          },
                          child: const Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 247, 110, 110),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.3,
                  //   child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: FutureBuilder(
                  //         future: upcomingCampaigns,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return const CircularProgressIndicator();
                  //           } else if (snapshot.hasData) {
                  //             final posts = snapshot.data!;

                  //             if (snapshot.data.length <= 0) {
                  //               return const Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "No data found",
                  //                     style: TextStyle(
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.w400,
                  //                     ),
                  //                   )
                  //                 ],
                  //               );
                  //             }

                  //             return ListView.builder(
                  //               scrollDirection: Axis.vertical,
                  //               itemCount: snapshot.data.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return UpComingEvents(
                  //                   eventName: snapshot.data[index]["title"],
                  //                   eventSubTitle: snapshot.data[index]
                  //                       ["description"],
                  //                   eventImage: snapshot.data[index]
                  //                       ["attachment"],
                  //                   eventStartDate: snapshot.data[index]
                  //                       ["startDate"],
                  //                 );
                  //               },
                  //             );
                  //           } else {
                  //             return const Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [Text("No data found")],
                  //             );
                  //           }
                  //         },
                  //       )

                  //       // child: ListView.builder(
                  //       //     itemCount: 4,
                  //       //     itemBuilder: (context, index) {
                  //       //       return UpComingEvents(
                  //       //         eventName: upcomingevent[index][0],
                  //       //         eventSubTitle: upcomingevent[index][1],
                  //       //         eventImage: upcomingevent[index][2],
                  //       //         eventStartDate: upcomingevent[index][3],
                  //       //       );
                  //       //     }),
                  //       ),
                  // ),

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
        Spacer(),
        Text(
          "See All",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 247, 110, 110)),
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

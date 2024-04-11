import 'package:deviginite_app/Fragments.dart/learningPage.dart';
import 'package:deviginite_app/provider/bottomNavigationprovider.dart';
import 'package:deviginite_app/provider/flutterTts2provider.dart';
import 'package:deviginite_app/screens/students/b_home_screen.dart';
import 'package:deviginite_app/screens/students/b_learning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../screens/students/profile_screen.dart';

class UserDashBoard extends ConsumerStatefulWidget {
  const UserDashBoard({super.key});

  @override
  ConsumerState<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends ConsumerState<UserDashBoard> {
  void initState() {
    super.initState();
    ref.read(FLutterTTSProvider2.notifier).assignRouteFun(gotTORoute);
  }

  int _currentIndex = 1;
  final tabs = [
    BHomeScreen(),
    BlindHomePage(),
    ProfileScreen(),
  ];
  void gotTORoute(int data) {
    print(data);
    ref.read(BottomNaigationProvider.notifier).selectSub(data);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(BottomNaigationProvider);
    _currentIndex = ref.read(BottomNaigationProvider.notifier).selectedSubIs();
    // print("my Cureent is " + _currentIndex.toString());
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showUnselectedLabels: true,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                ref.read(BottomNaigationProvider.notifier).selectSub(0);
              },
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.book),
              onPressed: () {
                ref.read(BottomNaigationProvider.notifier).selectSub(1);
              },
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () {
                ref.read(BottomNaigationProvider.notifier).selectSub(2);
              },
            ),
            label: "Profile",
          )
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.more_horiz),
          //   label: "More",
          // ),
        ],
      ),
      //give the navbar on specific page itself.
      // appBar: AppBar(
      //   title: const Text(
      //     "Eventia",
      //     style: const TextStyle(
      //         fontFamily: 'Specimen',
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      //   toolbarHeight: 70,
      //   automaticallyImplyLeading: false,
      // ),
      body: tabs[_currentIndex],
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       child: Center(child: Text('This s a homepage of a user! ')),
      //     )
      //   ],
      // ),
    );
  }
}

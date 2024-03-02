import 'package:deviginite_app/screens/students/b_home_screen.dart';
import 'package:deviginite_app/screens/students/b_learning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../screens/students/profile_screen.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int _currentIndex = 0;
  final tabs = [
    BHomeScreen(),
    BLearningScreen(),
    // SearchPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Learnings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Profile",
          ),
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
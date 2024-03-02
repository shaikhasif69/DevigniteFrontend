import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../screens/splash_screen.dart';

// import '../screens/home_screen.dart';
// import '../tabs/dashboard_nav.dart';
// import '../screens/splash_screen.dart';

class AppRoutes {
  static List<GetPage> generateRoutes = [
    GetPage(name: '/', page: () => SplashScreen()),
    // // GetPage(name: '/introPage', page: () => IntroScreenPage()),
    // GetPage(name: '/login', page: () => LoginPage()),
    // GetPage(name: '/searchLocation', page: () => SearchLocationWidget()),
    // // GetPage(name: '/userDashboard', page: () => UserDashBoard()),
    // // GetPage(name: "/userRegisteration", page: () => UserReg()),
    // // GetPage(name: "/managerDashboard", page: () => ManagerDashboard()),
    // // GetPage(name: "/viewEvents", page: () => ViewEvent()),
    // // GetPage(name: "/event", page: () => EventCard()),
    // // GetPage(name: "/addEvent", page: () => AddEvent()),
    // // GetPage(name:"/addTaskandManager",page:()=>addTaskandManager()),
    // GetPage(name: '/userDashboard', page: () => UserDashBoard()),
    // GetPage(name: '/getAllCampaigns', page: () => AllCampaigns()),
    // GetPage(
    //   name: '/getAllUpcomingCampaigns',
    //   page: () => AllUpcomingCampaignsPage(),
    // ),

    // GetPage(
    //     name: '/eventDeatilsPage',
    //     page: () => DetailPage(),
    //     binding: BindingsBuilder.put(() => DetailController(MyEvent))),

    //dummy
    // GetPage(name: '/selectMember', page: () => addTaskandManager())
  ];
}

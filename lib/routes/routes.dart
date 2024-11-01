import 'package:get/get.dart';
import 'package:restaurant_vendor_app/views/LoginView/loginPage.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage2.dart';
import 'package:restaurant_vendor_app/views/main_screens/history_screen/history_screen.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/VerificationPage.dart';
import 'package:restaurant_vendor_app/views/main_screens/scanner_screen/scanner_screen.dart';
import 'package:restaurant_vendor_app/views/notifaicatio/notification_screen_page_priyanka.dart';
import 'package:restaurant_vendor_app/views/pages/dashboard/dashboard.dart';
import 'package:restaurant_vendor_app/views/pages/dashboard/dashboard_binding.dart';
import 'package:restaurant_vendor_app/views/pages/onboarding/boarding_screen.dart';
import 'package:restaurant_vendor_app/views/setting/setting_page.dart';
import 'package:restaurant_vendor_app/views/tickets/raise_ticket.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      transition: Transition.fadeIn,
      name: '/boarding_screens',
      page: () => BoardingScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/signup',
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: '/signup2',
      page: () => const SignUpPage2(),
    ),
    GetPage(
      name: '/verification_screen',
      page: () => const VerificationPage(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/scanner',
      page: () => ScannerScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/orderview',
      page: () => OrderHistoryView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: '/appsetting',
      page: () => const SettingsPagex(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),

    // ----------SettingScreen Routes
    // GetPage(
    //   name: '/onsettingprofile',
    //   page: () => const (),
    // ),
    // GetPage(
    //   name: '/onsettingpasswordreset',
    //   page: () => const (),
    // ),
    GetPage(
      name: '/onsettingnotification',
      page: () => const NotificationsSettingsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // GetPage(
    //   name: '/onsettingrate&review',
    //   page: () => const (),
    // ),
    // GetPage(
    //   name: '/onsettinghelp',
    //   page: () => const (),
    // ),
    GetPage(
      name: '/onsettingsubmitissue',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const SubmitIssuePage(),
    ),
  ];
}

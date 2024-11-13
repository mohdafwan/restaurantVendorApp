import 'package:get/get.dart';
import 'package:restaurant_vendor_app/views/EditProfileView/EditProfilePage.dart';
import 'package:restaurant_vendor_app/views/Labels/change_color_edit_label.dart';
import 'package:restaurant_vendor_app/views/Labels/food_label.dart';
import 'package:restaurant_vendor_app/views/Labels/labels.dart';
import 'package:restaurant_vendor_app/views/Labels/new_food_label.dart';
import 'package:restaurant_vendor_app/views/LoginView/loginPage.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage.dart';
import 'package:restaurant_vendor_app/views/SignUpView/signUpPage2.dart';
import 'package:restaurant_vendor_app/views/main_screens/history_screen/history_screen.dart';
import 'package:restaurant_vendor_app/views/main_screens/home_screen/VerificationPage.dart';
import 'package:restaurant_vendor_app/views/notifaicatio/notification_screen_page_priyanka.dart';
import 'package:restaurant_vendor_app/views/pages/dashboard/dashboard.dart';
import 'package:restaurant_vendor_app/views/pages/dashboard/dashboard_binding.dart';
import 'package:restaurant_vendor_app/views/pages/onboarding/boarding_screen.dart';
import 'package:restaurant_vendor_app/views/setting/setting_page.dart';
import 'package:restaurant_vendor_app/views/settings/help_page.dart';
import 'package:restaurant_vendor_app/views/tickets/raise_ticket.dart';

import '../views/main_screens/home_screen/search_screen/search_page.dart';

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

    GetPage(
      name: '/search',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const SearchPage(),
    ),

    GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: '/help',
      page: () => const HelpPage(),
    ),

    GetPage(
      name: '/labels',
      page: () => const Labels(),
    ),

    GetPage(
      name: '/foodLabel',
      page: () => const FoodLabel(),
    ),

    GetPage(
      name: '/changeColorEditLabel',
      page: () => const ChangeColorEditLabel(),
    ),
    GetPage(
      name: '/newFoodLabel',
      page: () => const NewFoodLabel(),
    ),
GetPage(
      name: '/editProfilePage',
      page: () => const EditProfilePage(),
    ),

  ];
}

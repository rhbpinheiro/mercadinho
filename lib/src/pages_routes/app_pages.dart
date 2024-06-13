import 'package:get/get.dart';
import 'package:mercadinho/src/pages/auth/view/sign_in_page.dart';
import 'package:mercadinho/src/pages/auth/view/sign_up_page.dart';
import 'package:mercadinho/src/pages/home/home_page.dart';
import 'package:mercadinho/src/pages/splash/splash_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashPage(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => const SignInPage(),
      name: PagesRoutes.sigInRoute,
    ),
    GetPage(
      page: () => const SignUpPage(),
      name: PagesRoutes.sigUpRoute,
    ),
    GetPage(
      page: () => const HomePage(),
      name: PagesRoutes.homeRoute,
    ),
  ];
}

abstract class PagesRoutes {
  static const String sigInRoute = '/signin';
  static const String sigUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String homeRoute = '/';
}

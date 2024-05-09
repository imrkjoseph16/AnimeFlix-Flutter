import 'package:anime_nation/dashboard/pages/home/all/see_all_contents_page.dart';
import 'package:anime_nation/dashboard/presentation/dashboard_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:anime_nation/login/login_page.dart';
import 'package:anime_nation/register/register_page.dart';
import 'package:anime_nation/splash/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/details':
        final args = settings.arguments as DetailsArguments;
        return PageTransition(
            child: DetailsPage(args: args),
            type: PageTransitionType.rightToLeft);
      case '/seeall':
        final args = settings.arguments as SeelAllContentArguments;
        return PageTransition(
            child: SeeAllContentPage(args: args),
            type: PageTransitionType.rightToLeft);
      case '/watch':
        final args = settings.arguments as VideoStreamingArguments;
        return PageTransition(
            child: VideoStreamingPage(args: args),
            type: PageTransitionType.fade);
      case '/dashboard':
        return PageTransition(
            child: const DashboardPage(),
            type: PageTransitionType.rightToLeftWithFade);
      case '/register':
        return PageTransition(
            child: const RegisterPage(), type: PageTransitionType.rightToLeft);
      case '/login':
        return PageTransition(
            child: const LoginPage(), type: PageTransitionType.rightToLeft);
      default:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
    }
  }
}

import 'package:anime_nation/dashboard/pages/home/all/see_all_contents_page.dart';
import 'package:anime_nation/dashboard/presentation/dashboard_page.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  final SharedBloc sharedBloc = SharedBloc();
  final ExploreBloc exploreBloc = ExploreBloc();
  final VideoStreamingBloc streamBloc = VideoStreamingBloc();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/details':
        final args = settings.arguments as DetailsArguments;
        return PageTransition(
            child: BlocProvider.value(
                value: sharedBloc,
                child: DetailsPage(detailsId: args.detailsId)),
            type: PageTransitionType.rightToLeft);
      case '/seeall':
        final args = settings.arguments as SeelAllContentArguments;
        return PageTransition(
            child: SeeAllContentPage(args: args),
            type: PageTransitionType.rightToLeft);
      case '/watch':
        final args = settings.arguments as VideoStreamingArguments;
        return PageTransition(
            child: BlocProvider.value(
                value: streamBloc, child: VideoStreamingPage(args: args)),
            type: PageTransitionType.fade);
      default:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
    }
  }

  void dispose() {
    sharedBloc.close();
    exploreBloc.close();
    streamBloc.close();
  }
}

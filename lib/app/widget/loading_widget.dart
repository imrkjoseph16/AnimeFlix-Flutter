import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  double? loadingSize;
  LoadingWidget({super.key, this.loadingSize});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: loadingSize ?? 80,
        child: Lottie.asset(
          'assets/lottie/movie_logo_loading_animation.json',
          frameRate: FrameRate.max,
        ),
      );
}

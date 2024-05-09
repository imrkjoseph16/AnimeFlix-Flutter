// ignore_for_file: must_be_immutable

import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutomaticPagerView extends StatefulWidget {
  List<Results>? data;
  Function(String)? onItemClicked = (_) => {};
  AutomaticPagerView({super.key, required this.data, this.onItemClicked});

  @override
  _AutomaticPagerViewState createState() => _AutomaticPagerViewState();
}

class _AutomaticPagerViewState extends State<AutomaticPagerView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed &&
          widget.data?.isNotEmpty == true) {
        _animationController.reset();
        int page = widget.data!.length - 1;

        if (page > _currentPage) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInSine);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Material(
      type: MaterialType.transparency,
      child: Ink(
        child: InkWell(
          onTap: () =>
              widget.onItemClicked?.call(widget.data?[_currentPage].id ?? ""),
          splashColor: Colors.grey.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: SizedBox(
                    height: 600.0,
                    child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.data?.length ?? 0,
                        onPageChanged: (value) {
                          _currentPage = value;
                          _animationController.forward();
                        },
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: double.infinity,
                              child: Image.network(
                                widget.data?[index].image ?? "",
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ));
                        })),
              ),

              // PagerView Indicator
              Transform.translate(
                offset: const Offset(20, -30),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.data?.length ?? 1,
                  effect: const WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      strokeWidth: 5,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.red),
                  onDotClicked: (index) => {
                    _currentPage = index,
                    _pageController.animateToPage(
                      index,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                    )
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

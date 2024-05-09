import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:flutter/material.dart';

class SmallCardWidget extends StatelessWidget {
  String itemId;
  String? firstLine;
  String? image;
  Function(String)? onItemClicked = (_) => {};
  double? cardHeight;
  // For continue watching components
  bool? canShowControls;
  double? progressValue;
  String? bottomTextLine;
  SmallCardWidget(
      {super.key,
      required this.itemId,
      this.firstLine,
      this.image,
      this.onItemClicked,
      this.cardHeight,
      this.canShowControls,
      this.progressValue,
      this.bottomTextLine});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
          width: 150.0,
          height: cardHeight,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(image ?? "")),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey,
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              onTap: () {
                onItemClicked?.call(itemId ?? "");
              },
              splashColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Text(firstLine ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "SfProTextBold",
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        )),
                    Visibility(
                      visible: canShowControls != null,
                      child: Stack(children: [
                        const Align(
                            alignment: Alignment.center,
                            child: Icon(CustomIcons.play_circle,
                                size: 45, color: Colors.white)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(bottomTextLine ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "SfProTextBold",
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 6.0,
                                        color: Colors.red,
                                        offset: Offset(3.0, 3.0),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.red),
                                  value: progressValue ?? 0),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

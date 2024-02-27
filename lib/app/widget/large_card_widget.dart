import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LargeCardWidget extends StatelessWidget {
  String itemId;
  String? firstLine;
  String? secondLine;
  String? thirdline;
  String? image;
  int? starRating = 0;
  bool? isHorizontal = false;
  Function(String)? onItemClicked = (_) => {};
  LargeCardWidget(
      {super.key,
      required this.itemId,
      this.firstLine,
      this.secondLine,
      this.thirdline,
      this.image,
      this.starRating,
      this.isHorizontal,
      this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    onItemClicked?.call(itemId);
                  },
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Title //
                        const SizedBox(height: 8.0),
                        Text(firstLine ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
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

                        // Description //
                        const SizedBox(height: 8.0),
                        Html(
                          data: secondLine ?? "",
                          style: {
                            "body": Style(
                              textShadow: [
                                const Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ],
                              margin: Margins.all(0),
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: FontSize(14),
                              fontFamily: "SfProTextMedium",
                              color: Colors.white,
                            ),
                          },
                        ),

                        // Type //
                        const SizedBox(height: 12),
                        Text(thirdline ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
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

                        // Ratings //
                        Align(
                          alignment: FractionalOffset.bottomRight,
                          child: RatingBar.builder(
                            initialRating: starRating?.toDouble() ?? 1,
                            minRating: 1,
                            maxRating: 100,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          isHorizontal == true ? const SizedBox(height: 16) : const Spacer()
        ],
      ),
    );
  }
}

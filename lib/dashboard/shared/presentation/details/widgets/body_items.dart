import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BodyItems extends StatelessWidget {
  BuildContext context;
  AnimeDetailsResponse? response;
  BodyItems({super.key, required this.context, this.response});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title //
              Flexible(
                child: Text(
                    response?.title?.english ?? response?.title?.native ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
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
              ),
              const Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.share,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),

          // Type //
          const SizedBox(height: 8),
          Text(response?.type ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              )),

          // Year, Status Details //
          const SizedBox(height: 24),
          Row(
            children: [
              Text(response?.releaseDate.toString() ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "SfProTextBold",
                    color: Colors.white,
                  )),
              const SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Chip(
                  backgroundColor: Colors.black,
                  label: Text(
                    response?.status ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SfProTextRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Chip(
                  backgroundColor: Colors.black,
                  label: Text(
                    response?.totalEpisodes.toString() ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SfProTextRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Chip(
                  backgroundColor: Colors.black,
                  label: Text(
                    response?.subOrDub ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SfProTextRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),

          // Watch and Download Buttons //
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                    onPressed: () => goToStreamScreen(
                        episode: Default.DEFAULT_SELECTED_EPISODE),
                    child: const Text("Watch",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "SfProTextRegular",
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                    onPressed: () => {},
                    child: const Text("Download",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "SfProTextRegular",
                          fontWeight: FontWeight.bold,
                        ))),
              )
            ],
          ),

          // Genres //
          const SizedBox(height: 16),
          Text("Genres: ${ViewUtil.extractGenres(response?.genres)}",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              )),

          // Description //
          const SizedBox(height: 16),
          Html(
            data: response?.description ?? "",
            style: {
              "body": Style(
                margin: Margins.all(0),
                fontSize: FontSize(14),
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              ),
            },
          ),
        ],
      ),
    );
  }

  void goToStreamScreen({required num episode}) {
    Navigator.of(context).pushNamed('/watch',
        arguments: VideoStreamingArguments(
            details: response, selectedEpisode: episode));
  }
}

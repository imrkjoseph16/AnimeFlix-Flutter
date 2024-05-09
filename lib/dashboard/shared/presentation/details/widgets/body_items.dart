// ignore_for_file: must_be_immutable

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:anime_nation/shared/data/video_watched_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class BodyItems extends StatefulWidget {
  final String parentId;
  final ItemType itemType;
  BuildContext context;
  DetailsFullData? response;
  BodyItems(
      {super.key,
      required this.parentId,
      required this.itemType,
      required this.context,
      this.response});

  @override
  State<BodyItems> createState() => _BodyItemsState();
}

class _BodyItemsState extends State<BodyItems> {
  var util = locator.get<ViewUtil>();
  VideoWatchedDetails? watchedDetails;

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
                    widget.response?.title?.native ??
                        widget.response?.title?.userPreferred ??
                        widget.response?.countryOfOrigin ??
                        widget.response?.title?.english ??
                        "",
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
              const SizedBox(width: 16),
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
          Text(widget.response?.type ?? widget.response?.releaseDate ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              )),

          // Year, Status Details //
          const SizedBox(height: 16),
          Row(
            children: [
              Text(widget.response?.releaseDate.toString() ?? "",
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
                    widget.response?.status ??
                        widget.response?.isAdult.toString() ??
                        "",
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
                    (widget.response?.totalEpisodes ?? 1).toString(),
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
                    widget.response?.subOrDub ?? "",
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
              StatefulBuilder(builder: (context, setState) {
                return BlocListener<VideoStreamingBloc, VideoStreamingState>(
                  listener: (context, state) {
                    if (state is OnVerifyWatchedDurationState) {
                      setState(() => watchedDetails = state.watchedDetails);
                    }
                  },
                  child: Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                        onPressed: () => goToStreamScreen(
                            episode: watchedDetails?.watchedEpisode ??
                                Default.DEFAULT_SELECTED_EPISODE,
                            lastDuration: watchedDetails?.duration),
                        child: Text(watchedDetails != null ? "Resume" : "Watch",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "SfProTextBold",
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                );
              }),
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

          // Description //
          const SizedBox(height: 16),
          Html(
            data: widget.response?.description ?? "",
            style: {
              "body": Style(
                margin: Margins.all(0),
                fontSize: FontSize(14),
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              ),
            },
          ),

          // Genres //
          const SizedBox(height: 16),
          Visibility(
            visible: widget.response?.genres != null,
            child:
                Text("Genres: ${util.extractString(widget.response?.genres)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "SfProTextMedium",
                      color: Colors.white,
                    )),
          ),

          // Other Names //
          const SizedBox(height: 8),
          Visibility(
            visible: widget.response?.otherNames != null,
            child: Text(
                "Other names: ${util.extractString(widget.response?.otherNames)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "SfProTextMedium",
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  void goToStreamScreen(
      {required num episode,
      // for continue watching list,
      // incase stream is unfinish watching.
      int? lastDuration}) {
    Navigator.of(widget.context).pushNamed('/watch',
        arguments: VideoStreamingArguments(
            detailsId: widget.parentId,
            itemType: widget.itemType,
            selectedEpisode: episode,
            lastDuration: lastDuration,
            typeOfMovie: widget.response?.type));
  }
}

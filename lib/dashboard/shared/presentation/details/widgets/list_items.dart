// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:anime_nation/app/widget/avatar_widget.dart';
import 'package:anime_nation/app/widget/card_play_details_widget.dart';
import 'package:anime_nation/app/widget/empty_data_widget.dart';
import 'package:anime_nation/app/widget/large_card_widget.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:flutter/material.dart';

class ListItemsWidget extends StatelessWidget {
  final ItemType itemType;
  final String parentId;
  BuildContext context;
  DetailsFullData? response;
  SelectionType selectedType = SelectionType.EPISODES;
  Map<SelectionType, Widget> optionItems = {};

  ListItemsWidget(
      {super.key,
      required this.parentId,
      required this.itemType,
      required this.context,
      this.response});

  @override
  Widget build(BuildContext context) {
    setupTabOptions();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(children: [
        Visibility(
            visible: response?.characters?.isNotEmpty == true &&
                response?.characters != null,
            child: CastsWidget()),
        SelectionsWidget()
      ]),
    );
  }

  Widget CastsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Casts Title and Items //
        const Text("Casts",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "SfProTextBold",
              color: Colors.white,
            )),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: response?.characters?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return AvatarWidget(
                results: response?.characters?[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget SelectionsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Other Selections Tab //
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              DefaultTabController(
                length: optionItems.length,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  onTap: (position) {
                    setState(() => selectedType =
                        optionItems.entries.toList()[position].key);
                  },
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    for (var optionWidgets in optionItems.values) optionWidgets
                  ],
                ),
              ),

              // Other Selections List Items //
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  getOthersItemCount(selectedType) == 0
                      ? EmptyDataWidget()
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: getOthersItemCount(selectedType),
                          itemBuilder: (BuildContext context, int index) {
                            switch (selectedType) {
                              case SelectionType.RELATED:
                                Relations? result = response?.relations?[index];
                                return LargeCardWidget(
                                    itemId: result?.id.toString() ?? "",
                                    firstLine: result?.title?.english ??
                                        result?.title?.native,
                                    secondLine: result?.relationType,
                                    thirdline: result?.status,
                                    image: result?.cover ?? result?.image,
                                    isHorizontal: true,
                                    onItemClicked: (detailsId) =>
                                        goToDetailsScreen(
                                            type: itemType,
                                            detailsId: detailsId));
                              case SelectionType.RECOMMENDATION:
                                Recommendations? result =
                                    response?.recommendations?[index];
                                return LargeCardWidget(
                                  itemId: result?.id.toString() ?? "",
                                  firstLine: result?.title?.english ??
                                      result?.title?.native,
                                  secondLine: result?.type,
                                  thirdline: result?.status,
                                  image: result?.cover ?? result?.image,
                                  starRating: result?.rating?.toInt(),
                                  isHorizontal: true,
                                  onItemClicked: (detailsId) =>
                                      goToDetailsScreen(
                                          type: itemType, detailsId: detailsId),
                                );
                              default:
                                Episodes? result;
                                if (itemType == ItemType.MOVIES) {
                                  result =
                                      response?.seasons?[0].episodes?[index];
                                } else {
                                  result = response?.episodes?[index];
                                }

                                return CardPlayDetailsWidget(
                                  cardEnabled: true,
                                  itemId: result?.id ?? "",
                                  firstLine: response?.title?.english ??
                                      response?.title?.native,
                                  secondLine: "Episode: ${result?.number}",
                                  thirdLine: result?.type ??
                                      "Status: ${response?.status}",
                                  image: result?.image ?? response?.image,
                                  onItemClicked: (episodeId) {
                                    goToStreamScreen(
                                        selectedEpisode: result?.number ?? 1);
                                  },
                                );
                            }
                          },
                        ),
                ],
              )
            ]);
          },
        )
      ],
    );
  }

  Map<SelectionType, Widget> setupTabOptions() {
    optionItems[SelectionType.EPISODES] = setupTab(title: "Episodes");
    optionItems[SelectionType.RELATED] = setupTab(title: "Related");
    optionItems[SelectionType.RECOMMENDATION] = setupTab(title: "Recommended");
    return optionItems;
  }

  Widget setupTab({required String title}) => Tab(
        child: Text(title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "SfProTextBold",
              color: Colors.white,
            )),
      );

  int getOthersItemCount(SelectionType selectedType) {
    switch (selectedType) {
      case SelectionType.RELATED:
        return response?.relations?.take(10).length ?? 0;
      case SelectionType.RECOMMENDATION:
        return response?.recommendations?.take(10).length ?? 0;
      default:
        if (itemType == ItemType.MOVIES &&
            response?.seasons?.isNotEmpty == true) {
          return response?.seasons?[0].episodes?.take(10).length ?? 0;
        } else {
          return response?.episodes?.take(10).length ?? 0;
        }
    }
  }

  void goToDetailsScreen({required ItemType type, required String detailsId}) =>
      Navigator.of(context).popAndPushNamed(
        '/details',
        arguments: DetailsArguments(type: type, detailsId: detailsId),
      );

  void goToStreamScreen({required num selectedEpisode}) =>
      Navigator.of(context).pushNamed('/watch',
          arguments: VideoStreamingArguments(
              detailsId: parentId,
              itemType: itemType,
              selectedEpisode: selectedEpisode,
              typeOfMovie: response?.type));
}

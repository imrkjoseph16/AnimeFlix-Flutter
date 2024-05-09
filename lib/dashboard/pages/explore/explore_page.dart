// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'dart:math';

import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:anime_nation/app/widget/empty_data_widget.dart';
import 'package:anime_nation/app/widget/loading_widget.dart';
import 'package:anime_nation/app/widget/small_card_widget.dart';
import 'package:anime_nation/dashboard/pages/explore/bloc/explore_bloc.dart';
import 'package:anime_nation/app/widget/search_field_widget.dart';
import 'package:anime_nation/dashboard/pages/home/all/see_all_contents_page.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin<ExplorePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => ExploreBloc(),
        child: Material(
            color: Colors.black,
            child: Stack(
              children: [
                const ExploreBody(),
                SearchFieldWidget(
                  onSearchCallBack: (context, searchValue) =>
                      getExploreContent(context, searchValue),
                ),
              ],
            )));
  }
}

void getExploreContent(BuildContext context, String queryName) {
  if (queryName.isEmpty) {
    sendExploreEvent(context, ItemType.EXPLORE, Default.DEFAULT_ANIME_EXPLORE);
  } else {
    sendExploreEvent(context, ItemType.ANIME, queryName);
    sendExploreEvent(context, ItemType.KOREAN, queryName);
    sendExploreEvent(context, ItemType.MOVIES, queryName);
  }
}

void sendExploreEvent(BuildContext context, ItemType type, String queryName) =>
    context.read<ExploreBloc>().add(GetExploreEvent(
        type: type,
        queryName: queryName,
        itemReset: type == ItemType.EXPLORE ? true : false));

class ExploreBody extends StatefulWidget {
  const ExploreBody({super.key});

  @override
  State<ExploreBody> createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  void initState() {
    super.initState();
    sendExploreEvent(context, ItemType.EXPLORE, Default.DEFAULT_ANIME_EXPLORE);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(builder: (context, state) {
      if (state is GetExploreList) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultContents(state.uiItems),
              ExploreContents(state.uiItems)
            ],
          ),
        );
      } else {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingWidget(),
            ));
      }
    });
  }

  Widget ResultContents(ExploreUiItems? uiItems) {
    return Column(
      children: [
        canShowResultWidgets(uiItems)
            ? Column(
                children: [
                  const SizedBox(height: 125),
                  SmallSectionList(
                      itemType: ItemType.ANIME,
                      sectionTitle: "Anime Result",
                      items: uiItems?.animeResult),
                  SmallSectionList(
                      itemType: ItemType.KOREAN,
                      sectionTitle: "Korean Result",
                      items: uiItems?.koreanResult),
                  SmallSectionList(
                      itemType: ItemType.MOVIES,
                      sectionTitle: "Movies Result",
                      items: uiItems?.movieResult),
                ],
              )
            : uiItems?.itemReset == false
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: EmptyDataWidget(
                        title: "Oh sorry! We don't have that for now.",
                        icon: const Icon(
                          CustomIcons.sad_tear,
                          size: 80.0,
                          color: Colors.white,
                        ),
                        description:
                            "Try searching for another anime, korean or movies.",
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
      ],
    );
  }

  bool canShowResultWidgets(ExploreUiItems? uiItems) {
    return uiItems?.animeResult?.results?.isNotEmpty == true ||
        uiItems?.koreanResult?.results?.isNotEmpty == true ||
        uiItems?.movieResult?.results?.isNotEmpty == true;
  }

  Widget SmallSectionList(
      {required ItemType itemType,
      required String sectionTitle,
      required ListFullData? items}) {
    return Visibility(
      visible: items?.results?.isNotEmpty == true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 8.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionTitle,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "SfProTextBold",
                      color: Colors.white),
                ),
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () => goToSeeAllScreen(
                      type: itemType, title: sectionTitle, response: items),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "SfProTextBold",
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: items?.results?.take(15).length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Results? result = items?.results?.take(15).toList()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmallCardWidget(
                    itemId: result?.id ?? "",
                    firstLine: result?.title?.english ?? result?.title?.native,
                    image: result?.image ?? result?.cover,
                    onItemClicked: (detailsId) {
                      goToDetailsScreen(itemType, detailsId, result?.type);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ExploreContents(ExploreUiItems? uiItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 8,
              top: uiItems?.itemReset == true ? 140 : 32,
              bottom: 8),
          child: const Text("Recommended Anime Series & Movies",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "SfProTextBold",
                shadows: [
                  Shadow(
                    blurRadius: 8.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              )),
        ),
        uiItems?.exploreResult != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MasonryGridView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    itemCount: uiItems?.exploreResult?.results?.length ?? 0,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      Results? result = uiItems?.exploreResult?.results?[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmallCardWidget(
                          cardHeight: Random().nextInt(350).toDouble() + 100,
                          itemId: result?.id ?? "",
                          firstLine:
                              result?.title?.english ?? result?.title?.native,
                          image: result?.image ?? result?.cover,
                          onItemClicked: (detailsId) {
                            goToDetailsScreen(
                                ItemType.ANIME, detailsId, result?.type);
                          },
                        ),
                      );
                    }),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(
                    child: EmptyDataWidget(
                  title: "No available contents found",
                )),
              )
      ],
    );
  }

  void goToDetailsScreen(ItemType type, String detailsId, String? typeOfMovie) {
    Navigator.of(context).pushNamed(
      '/details',
      arguments: DetailsArguments(
          type: type, detailsId: detailsId, typeOfMovie: typeOfMovie),
    );
  }

  void goToSeeAllScreen(
      {required ItemType type, required String title, ListFullData? response}) {
    Navigator.of(context).pushNamed('/seeall',
        arguments: SeelAllContentArguments(
            type: type, title: title, response: response));
  }
}

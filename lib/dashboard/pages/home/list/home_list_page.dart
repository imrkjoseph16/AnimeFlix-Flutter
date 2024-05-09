// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:anime_nation/app/widget/automatic_pager_view.dart';
import 'package:anime_nation/app/widget/large_card_widget.dart';
import 'package:anime_nation/app/widget/loading_widget.dart';
import 'package:anime_nation/app/widget/small_card_widget.dart';
import 'package:anime_nation/dashboard/pages/home/all/see_all_contents_page.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage>
    with AutomaticKeepAliveClientMixin<HomeListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => SharedBloc(),
      child: const HomeListBody(),
    );
  }
}

class HomeListBody extends StatefulWidget {
  const HomeListBody({super.key});

  @override
  State<HomeListBody> createState() => _HomeListBodyState();
}

class _HomeListBodyState extends State<HomeListBody> {
  @override
  void initState() {
    super.initState();
    getAnimeLists();
  }

  void getAnimeLists() {
    // Get Continue Watching List
    sendAnimeEvent(GetContinueWatchingEvent());

    // Get List of Anime's
    sendAnimeEvent(GetAnimeEvent(animeType: AnimeType.TRENDING));
    sendAnimeEvent(GetAnimeEvent(animeType: AnimeType.RECENT));
    sendAnimeEvent(GetAnimeEvent(animeType: AnimeType.POPULAR));
    sendAnimeEvent(GetAnimeEvent(animeType: AnimeType.RANDOM));
    sendAnimeEvent(GetAnimeEvent(animeType: AnimeType.AIRING));

    sendAnimeEvent(GetKoreanEvent(queryName: "Korean"));
    sendAnimeEvent(GetMovieEvent(queryName: "Popular"));
  }

  void sendAnimeEvent(SharedEvent event) =>
      BlocProvider.of<SharedBloc>(context).add(event);

  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          if (state is GetHomeItemsList) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PagerView Banner
                  AutomaticPagerView(
                      data: state.items?.carouselList,
                      onItemClicked: (id) => goToDetailsScreen(
                          context: context,
                          type: ItemType.ANIME,
                          detailsId: id)),

                  // Top Anime List //
                  SmallSectionList(
                      type: ItemType.ANIME,
                      sectionTitle: "Top 5 Anime this week",
                      items: state.items?.topAnime),

                  // Continue Watching List //
                  ContinueWatchList(
                      sectionTitle: "Continue Watching",
                      items: state.items?.continueWatchList),

                  // Random Movie Series //
                  LargeSectionList(
                      type: ItemType.MOVIES,
                      sectionTitle: "Random popular movies in this year",
                      items: state.items?.randomMovie),

                  // Latest Episodes Release //
                  SmallSectionList(
                      type: ItemType.ANIME,
                      sectionTitle: "Latest Episode Release",
                      items: state.items?.recentEpisodes),

                  // Random Anime's //
                  LargeSectionList(
                      type: ItemType.ANIME,
                      sectionTitle: "Random anime's that you might like",
                      items: state.items?.randomAnime),

                  // Popular Anime //
                  SmallSectionList(
                      type: ItemType.ANIME,
                      sectionTitle: "Popular Anime",
                      items: state.items?.popularAnime),

                  // Random Korean Series //
                  LargeSectionList(
                      type: ItemType.KOREAN,
                      sectionTitle: "Random korean series that you might like",
                      items: state.items?.randomKorean),

                  // Anime Airing Schedule //
                  SmallSectionList(
                      type: ItemType.ANIME,
                      sectionTitle: "Anime Airing Schedule",
                      items: state.items?.airingAnime),

                  const SizedBox(height: 20)
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
        },
      ),
    );
  }
}

class SmallSectionList extends StatelessWidget {
  ItemType type;
  String sectionTitle;
  ListFullData? items;
  SmallSectionList(
      {super.key, required this.type, required this.sectionTitle, this.items});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: items != null && items?.results?.isNotEmpty == true,
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
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "SfProTextBold",
                  ),
                ),
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () => goToSeeAllScreen(
                      context: context,
                      type: type,
                      title: sectionTitle,
                      response: items),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
              itemCount: items?.results?.take(10).length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Results? result = items?.results?.take(10).toList()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmallCardWidget(
                    itemId: result?.id ?? "",
                    firstLine: result?.title?.english,
                    image: result?.image,
                    progressValue:
                        ((result?.duration ?? 0) / (result?.totalDuration ?? 0))
                            .toDouble(),
                    bottomTextLine: "Episode: ${result?.watchedEpisode}",
                    onItemClicked: (detailsId) {
                      // we're redirecting to the stream screen,
                      // and will continue the unfinish watch.
                      goToStreamScreen(
                          context: context,
                          itemType: result?.itemType ?? ItemType.EXPLORE,
                          detailsId: detailsId,
                          watchedEpisode: result?.watchedEpisode ?? 0,
                          lastDuration: result?.duration ?? 0);
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
}

class LargeSectionList extends StatelessWidget {
  ItemType type;
  String sectionTitle;
  ListFullData? items;
  LargeSectionList(
      {super.key, required this.type, required this.sectionTitle, this.items});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: items != null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 8, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    sectionTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "SfProTextBold",
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () => goToSeeAllScreen(
                      context: context,
                      type: type,
                      title: sectionTitle,
                      response: items),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 180.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: items?.results?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Results? result = items?.results?[index];
                  return LargeCardWidget(
                    itemId: result!.id,
                    firstLine: result.title?.english ?? result.title?.native,
                    secondLine:
                        result.description ?? result.url ?? result.releaseDate,
                    thirdline: result.type,
                    image: result.cover ?? result.image,
                    starRating: result.rating,
                    onItemClicked: (detailsId) {
                      goToDetailsScreen(
                          context: context,
                          type: type,
                          detailsId: detailsId,
                          typeOfMovie: result.type);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContinueWatchList extends StatelessWidget {
  String sectionTitle;
  ListFullData? items;
  ContinueWatchList({super.key, required this.sectionTitle, this.items});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: items != null && items?.results?.isNotEmpty == true,
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
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "SfProTextBold",
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
              itemCount: items?.results?.take(10).length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Results? result = items?.results?.take(10).toList()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmallCardWidget(
                    itemId: result?.id ?? "",
                    firstLine: result?.title?.english,
                    image: result?.image,
                    canShowControls: true,
                    progressValue:
                        ((result?.duration ?? 0) / (result?.totalDuration ?? 0))
                            .toDouble(),
                    bottomTextLine: "Episode: ${result?.watchedEpisode}",
                    onItemClicked: (detailsId) {
                      // we're redirecting to the stream screen,
                      // and will continue the unfinish watch.
                      goToStreamScreen(
                          context: context,
                          itemType: result?.itemType ?? ItemType.EXPLORE,
                          detailsId: detailsId,
                          watchedEpisode: result?.watchedEpisode ?? 0,
                          lastDuration: result?.duration ?? 0);
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
}

void goToStreamScreen(
        {required BuildContext context,
        required ItemType itemType,
        required num watchedEpisode,
        required String detailsId,
        required int lastDuration}) =>
    Navigator.of(context).pushNamed('/watch',
        arguments: VideoStreamingArguments(
            detailsId: detailsId,
            itemType: itemType,
            selectedEpisode: watchedEpisode,
            lastDuration: lastDuration));

void goToDetailsScreen(
    {required BuildContext context,
    required ItemType type,
    required String detailsId,
    String? typeOfMovie}) {
  Navigator.of(context).pushNamed(
    '/details',
    arguments: DetailsArguments(
        type: type, detailsId: detailsId, typeOfMovie: typeOfMovie),
  );
}

void goToSeeAllScreen(
    {required BuildContext context,
    required ItemType type,
    required String title,
    ListFullData? response}) {
  Navigator.of(context).pushNamed('/seeall',
      arguments: SeelAllContentArguments(
          type: type, title: title, response: response));
}

// ignore_for_file: non_constant_identifier_names

import 'package:anime_nation/app/widget/automatic_pager_view.dart';
import 'package:anime_nation/app/widget/large_card_widget.dart';
import 'package:anime_nation/app/widget/small_card_widget.dart';
import 'package:anime_nation/dashboard/pages/home/all/see_all_contents_page.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
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
  void initState() {
    super.initState();
    getAnimeLists();
  }

  @override
  bool get wantKeepAlive => true;

  void getAnimeLists() {
    BlocProvider.of<SharedBloc>(context)
        .add(GetAnimeEvent(animeType: AnimeType.TRENDING));
    BlocProvider.of<SharedBloc>(context)
        .add(GetAnimeEvent(animeType: AnimeType.RECENT));
    BlocProvider.of<SharedBloc>(context)
        .add(GetAnimeEvent(animeType: AnimeType.POPULAR));
    BlocProvider.of<SharedBloc>(context)
        .add(GetAnimeEvent(animeType: AnimeType.RANDOM));
    BlocProvider.of<SharedBloc>(context)
        .add(GetAnimeEvent(animeType: AnimeType.AIRING));
  }

  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SharedBloc, SharedState>(
      builder: (context, state) {
        if (state is GetAnimeList) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // PagerView Banner
                AutomaticPagerView(
                    data: state.items?.carouselList,
                    onItemClicked: (id) => Navigator.of(context).pushNamed(
                          '/details',
                          arguments: DetailsArguments(detailsId: id),
                        )),

                // Top Anime List //
                SmallSectionList(
                    sectionTitle: "Top 10 Anime this week",
                    items: state.items?.topAnime),

                // Latest Episodes Release //
                SmallSectionList(
                    sectionTitle: "Latest Episode Release",
                    items: state.items?.recentEpisodes),

                // Random Anime's //
                LargeSectionList(
                    sectionTitle: "Random anime's that you might like",
                    items: state.items?.randomAnime),

                // Popular Anime //
                SmallSectionList(
                    sectionTitle: "Popular Anime",
                    items: state.items?.popularAnime),

                // Anime Airing Schedule //
                SmallSectionList(
                    sectionTitle: "Anime Airing Schedule",
                    items: state.items?.airingAnime),

                const SizedBox(height: 20)
              ],
            ),
          );
        } else {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget SmallSectionList(
      {required String sectionTitle, AnimeResponse? items}) {
    return Column(
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
                ),
              ),
              InkWell(
                splashColor: Colors.grey,
                onTap: () =>
                    goToSeeAllScreen(title: sectionTitle, response: items),
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
            itemCount: sectionTitle.contains("Top 10 Anime")
                ? items?.results?.skip(5).length
                : items?.results?.take(10).length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              Results? result = sectionTitle.contains("Top 10 Anime")
                  ? items?.results?.skip(5).toList()[index]
                  : items?.results?.take(10).toList()[index];
              return SmallCardWidget(
                itemId: result?.id ?? "",
                firstLine: result?.title?.english ?? result?.title?.native,
                image: result?.image ?? result?.cover,
                onItemClicked: (detailsId) {
                  Navigator.of(context).pushNamed(
                    '/details',
                    arguments: DetailsArguments(detailsId: detailsId),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget LargeSectionList(
      {required String sectionTitle, AnimeResponse? items}) {
    return Column(
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
                    fontSize: 18,
                    fontFamily: "SfProTextBold",
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.grey,
                onTap: () =>
                    goToSeeAllScreen(title: sectionTitle, response: items),
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
                  secondLine: result.description,
                  thirdline: result.type,
                  image: result.cover ?? result.image,
                  starRating: result.rating,
                  onItemClicked: (detailsId) {
                    Navigator.of(context).pushNamed(
                      '/details',
                      arguments: DetailsArguments(detailsId: detailsId),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void goToSeeAllScreen({required String title, AnimeResponse? response}) {
    Navigator.of(context).pushNamed('/seeall',
        arguments: SeelAllContentArguments(title: title, response: response));
  }
}

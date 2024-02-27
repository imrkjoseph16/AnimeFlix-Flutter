// ignore_for_file: must_be_immutable

import 'package:anime_nation/app/widget/large_card_widget.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/details_page.dart';
import 'package:flutter/material.dart';

class SeeAllContentPage extends StatefulWidget {
  SeelAllContentArguments args;
  SeeAllContentPage({super.key, required this.args});

  @override
  State<SeeAllContentPage> createState() => _SeeAllContentPageState();
}

class _SeeAllContentPageState extends State<SeeAllContentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                          size: 28,
                          shadows: <Shadow>[
                            Shadow(color: Colors.black, blurRadius: 15.0)
                          ],
                          Icons.arrow_back,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        widget.args.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "SfProTextBold",
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.args.response?.results?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Results? result = widget.args.response?.results?[index];
                        return LargeCardWidget(
                          itemId: result!.id,
                          firstLine:
                              result.title?.english ?? result.title?.native,
                          secondLine: result.description ??
                              result.status ??
                              result.episodeTitle,
                          thirdline: result.type,
                          image: result.cover ?? result.image,
                          starRating: result.rating,
                          isHorizontal: true,
                          onItemClicked: (detailsId) {
                            Navigator.of(context).pushNamed(
                              '/details',
                              arguments: DetailsArguments(detailsId: detailsId),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SeelAllContentArguments {
  String title;
  AnimeResponse? response;
  SeelAllContentArguments({required this.title, required this.response});
}

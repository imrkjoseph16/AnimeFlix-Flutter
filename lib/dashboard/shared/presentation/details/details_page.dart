// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:anime_nation/app/widget/error_found_widget.dart';
import 'package:anime_nation/app/widget/loading_widget.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/body_items.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/header_items.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/list_items.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart' as streamBloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  DetailsArguments args;
  DetailsPage({super.key, required this.args});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _sharedBloc = SharedBloc();
  final _streamBloc = streamBloc.VideoStreamingBloc();

  @override
  void dispose() {
    _sharedBloc.close();
    _streamBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _sharedBloc,
        ),
        BlocProvider(
          create: (context) => _streamBloc,
        ),
      ],
      child: DetailsBody(args: widget.args),
    );
  }
}

class DetailsBody extends StatefulWidget {
  DetailsArguments args;
  DetailsBody({super.key, required this.args});

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  bool isInitialLoad = true;
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
    verifyDetailsEvent();
  }

  void verifyDetailsEvent() {
    context.read<SharedBloc>().add(VerifyDetailsEvent(
        type: widget.args.type,
        detailsId: widget.args.detailsId,
        typeOfMovie: widget.args.typeOfMovie));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          if (state is GetItemDetails) {
            // check if the stream have unfinish duration.
            context.read<streamBloc.VideoStreamingBloc>().add(streamBloc.CheckWatchedDurationEvent(
                detailsId: state.details?.id ?? ""));
      
            return NestedScrollView(
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) =>
                      <Widget>[ToolBarWidget(state.details)],
              body: ListView(
                primary: true,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  BodyItems(
                      parentId: widget.args.detailsId,
                      itemType: widget.args.type,
                      context: context,
                      response: state.details),
                  ListItemsWidget(
                      parentId: widget.args.detailsId,
                      itemType: widget.args.type,
                      context: context,
                      response: state.details)
                ],
              ),
            );
          } else if (state is NoDataState) {
            return ErrorFoundWidget(
                imageAssetPath: "assets/icons/server_error_icon.png");
          } else if (state is LoadingState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: LoadingWidget(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget ToolBarWidget(DetailsFullData? details) {
    return SliverAppBar(
        iconTheme: const IconThemeData(
            shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 18.0)],
            color: Colors.white),
        expandedHeight: 550.0,
        pinned: true,
        backgroundColor: Colors.black,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var toolBarHeight = constraints.biggest.height;
          return FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 18, left: 13),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: toolBarHeight < 150.0 ? 45 : 0, right: 8),
                    child: Text(
                        details?.title?.english ?? details?.title?.native ?? "",
                        maxLines: toolBarHeight < 120.0 ? 1 : null,
                        overflow: toolBarHeight < 120.0
                            ? TextOverflow.ellipsis
                            : null,
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
                ],
              ),
              background: HeaderItemsWidget(
                  bannerImage: details?.image ?? details?.cover));
        }));
  }
}

class DetailsArguments {
  final ItemType type;
  final String detailsId;
  final String? typeOfMovie;
  DetailsArguments(
      {required this.type, required this.detailsId, this.typeOfMovie});
}

enum SelectionType {
  EPISODES,
  RELATED,
  RECOMMENDATION;
}

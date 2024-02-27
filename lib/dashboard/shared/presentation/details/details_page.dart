import 'package:anime_nation/app/widget/error_found_widget.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/body_items.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/header_items.dart';
import 'package:anime_nation/dashboard/shared/presentation/details/widgets/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  String detailsId;
  DetailsPage({super.key, required this.detailsId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isInitialLoad = true;
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SharedBloc>(context)
        .add(AnimeDetailsEvent(detailsId: widget.detailsId));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Material(
        color: Colors.black,
        child: BlocBuilder<SharedBloc, SharedState>(
          builder: (context, state) {
            if (state is GetAnimeDetails) {
              return Column(
                children: [
                  HeaderItemsWidget(bannerImage: state.details?.image ?? ""),
                  BodyItems(context: context, response: state.details),
                  ListItemsWidget(context: context, response: state.details)
                ],
              );
            } else if (state is NoDataState) {
              return const ErrorFoundWidget();
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailsArguments {
  final String detailsId;
  DetailsArguments({required this.detailsId});
}

enum SelectionType {
  EPISODES,
  RELATED,
  RECOMMENDATION;
}

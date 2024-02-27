import 'dart:math';

import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<ExploreBloc>(context)
        .add(ExploreAnimeEvent(queryName: Default.DEFAULT_ANIME_EXPLORE));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: Colors.black,
      child: BlocBuilder<ExploreBloc, SharedState>(builder: (context, state) {
        if (state is GetExploreList) {
          return SingleChildScrollView(
            child: MasonryGridView.builder(
                primary: false,
                itemCount: state.response?.results?.length ?? 0,
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                itemBuilder: (context, index) => SizedBox(
                      height: Random().nextInt(350).toDouble() + 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            state.response?.results?[index].image ?? "",
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
          );
        } else {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        }
      }),
    );
  }
}

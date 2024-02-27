import 'package:flutter/material.dart';

import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart'
    as DetailsResponse;

class AvatarWidget extends StatelessWidget {
  DetailsResponse.Characters? results;
  AvatarWidget({super.key, this.results});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(results?.image ?? ""),
        backgroundColor: Colors.transparent,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(results?.name?.full ?? "",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "SfProTextBold",
                color: Colors.white,
              )),
          Text(results?.role ?? "",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "SfProTextMedium",
                color: Colors.white,
              ))
        ],
      )
    ]);
  }
}

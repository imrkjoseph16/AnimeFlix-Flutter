// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart'
    as full_data;

class AvatarWidget extends StatelessWidget {
  full_data.Characters? results;
  AvatarWidget({super.key, this.results});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      results?.image != null
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                results?.image ?? "",
              ),
              backgroundColor: Colors.grey,
            )
          : const SizedBox.shrink(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_buildFullName(),
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
        ),
      )
    ]);
  }

  String _buildFullName() =>
      results?.name?.full ??
      "${results?.name?.first} ${results?.name?.last ?? ""}";
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'custom_icons.dart';

class EmptyDataWidget extends StatelessWidget {
  String? title;
  String? description;
  Icon? icon;
  EmptyDataWidget({super.key, this.title, this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(title ?? "Ooops, no available data right now",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontFamily: "SfProTextBold",
                  color: Colors.grey,
                )),
            const SizedBox(height: 16),
            icon ??
                const Icon(
                  CustomIcons.info_circle,
                  size: 80.0,
                  color: Colors.white,
                ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(description ?? "Please try again later",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "SfProTextMedium",
                    color: Colors.blue,
                  )),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ]);
  }
}

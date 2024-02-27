import 'package:flutter/material.dart';

import 'custom_icons.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Text("No available data right now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "SfProTextBold",
                  color: Colors.grey,
                )),
            SizedBox(height: 16),
            Icon(
              CustomIcons.info_circle,
              size: 80.0,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Please try again later",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "SfProTextMedium",
                    color: Colors.blue,
                  )),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ]);
  }
}

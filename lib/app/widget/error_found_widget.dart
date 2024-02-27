import 'package:flutter/material.dart';

import 'custom_icons.dart';

class ErrorFoundWidget extends StatelessWidget {
  const ErrorFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("404 Server Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "SfProTextBold",
                    color: Colors.red,
                  )),
              SizedBox(height: 16),
              Icon(
                CustomIcons.sad_cry,
                size: 80.0,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                    "Sorry! Something went wrong, I can't get the details right now, please try again later.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "SfProTextMedium",
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

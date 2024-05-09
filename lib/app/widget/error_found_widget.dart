// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_icons.dart';

class ErrorFoundWidget extends StatelessWidget {
  String? imageAssetPath;
  String? subtitle;
  ErrorFoundWidget({super.key, this.imageAssetPath, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageAssetPath != null
                  ? AssetImageWidget(assetPath: imageAssetPath)
                  : DefaultWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DefaultWidget() {
    return Column(
      children: [
        const Text("404 Server Code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "SfProTextBold",
              color: Colors.red,
            )),
        const SizedBox(height: 16),
        const Icon(
          CustomIcons.sad_tear,
          size: 80.0,
          color: Colors.white,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: _setupTextSubtitle(),
        ),
      ],
    );
  }

  Widget AssetImageWidget({String? assetPath}) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          height: 220,
          child: Image(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                assetPath ?? 'assets/icons/server_error_icon.png',
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: _setupTextSubtitle(),
        ),
      ],
    );
  }

  Widget _setupTextSubtitle() {
    return Text(
        subtitle ??
            "Oh no sorry, something wen't wrong, We'll fix it as soon as possible.",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: "SfProTextMedium",
          color: Colors.grey,
        ));
  }
}

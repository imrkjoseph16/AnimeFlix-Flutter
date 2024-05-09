// ignore_for_file: must_be_immutable

import 'package:anime_nation/app/widget/empty_data_widget.dart';
import 'package:flutter/material.dart';

class HeaderItemsWidget extends StatelessWidget {
  String? bannerImage;
  HeaderItemsWidget({super.key, required this.bannerImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              width: double.infinity,
              height: 550.0,
              child: bannerImage != null
                  ? Image.network(
                      bannerImage!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Center(child: EmptyDataWidget()),
            ),
          ),
        ])
      ],
    );
  }
}

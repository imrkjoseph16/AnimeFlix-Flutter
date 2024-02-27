import 'package:flutter/material.dart';

class HeaderItemsWidget extends StatelessWidget {
  String bannerImage;
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
              child: Image.network(
                bannerImage,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                        size: 28,
                        shadows: <Shadow>[
                          Shadow(color: Colors.black, blurRadius: 15.0)
                        ],
                        Icons.arrow_back,
                        color: Colors.white),
                  )),
            ),
          )
        ])
      ],
    );
  }
}

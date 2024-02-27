import 'package:flutter/material.dart';

class SmallCardWidget extends StatelessWidget {
  String itemId;
  String? firstLine;
  String? image;
  Function(String)? onItemClicked = (_) => {};
  SmallCardWidget(
      {super.key,
      required this.itemId,
      this.firstLine,
      this.image,
      this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: 150.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(image ?? "")),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey,
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              onTap: () {
                onItemClicked?.call(itemId ?? "");
              },
              splashColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(firstLine ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "SfProTextBold",
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    )),
              ),
            ),
          )),
    );
  }
}

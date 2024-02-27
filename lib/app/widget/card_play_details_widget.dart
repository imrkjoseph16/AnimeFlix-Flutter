// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:flutter/material.dart';

class CardPlayDetailsWidget extends StatelessWidget {
  String itemId;
  String? firstLine;
  String? secondLine;
  String? thirdLine;
  String? image;
  Function(String)? onItemClicked;
  bool? isHorizontal = false;
  bool? cardEnabled = true;
  CardPlayDetailsWidget(
      {super.key,
      required this.itemId,
      this.firstLine,
      this.secondLine,
      this.thirdLine,
      this.image,
      this.onItemClicked,
      this.isHorizontal,
      this.cardEnabled});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => onClickedCallBack(itemId),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize:
                isHorizontal == true ? MainAxisSize.min : MainAxisSize.max,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Stack(children: [
                  Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: cardEnabled == true ? 1.0 : 0.2,
                          fit: BoxFit.cover,
                          image: NetworkImage(image ?? "")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      onTap: () => onClickedCallBack(itemId),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(CustomIcons.youtube, color: Colors.red))
                ]),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                          text: firstLine ?? "",
                          textSize: 16,
                          font: "SfProTextBold"),
                      const SizedBox(height: 8),
                      TextWidget(text: secondLine ?? ""),
                      TextWidget(text: thirdLine ?? ""),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget TextWidget({required String text, double? textSize, String? font}) {
    return Text(text,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: textSize ?? 14,
          fontFamily: font ?? "SfProTextMedium",
          color: cardEnabled == true ? Colors.white : Colors.grey.shade600,
        ));
  }

  void onClickedCallBack(String itemId) {
    if (cardEnabled == true) {
      onItemClicked?.call(itemId);
    }
  }
}

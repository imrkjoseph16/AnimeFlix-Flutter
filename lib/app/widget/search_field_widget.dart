// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  Function(BuildContext, String)? onSearchCallBack;
  SearchFieldWidget({super.key, this.onSearchCallBack});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Timer? debounce;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(builder: (context, setState) {
          return Stack(alignment: Alignment.centerLeft, children: [
            Row(children: [
              Expanded(
                flex: 9,
                child: SearchBar(
                    controller: _textController,
                    textStyle: MaterialStateProperty.all(const TextStyle(
                      fontSize: 16,
                      fontFamily: "SfProTextMedium",
                    )),
                    onSubmitted: (value) {
                      if (debounce?.isActive ?? false) debounce?.cancel();
                      onSearchCallBack?.call(context, value);
                    },
                    onChanged: (value) {
                      setState(() => {});
                      if (debounce?.isActive ?? false) debounce?.cancel();
                      if (value.isEmpty)
                        onSearchCallBack?.call(context, value);
                      else
                        debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          onSearchCallBack?.call(context, value);
                        });
                    }),
              ),
              _buildRightIcons(context, setState),
            ]),
            _textController.text.isEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        _createAnimatedText(
                            "Explore some contents or movies..."),
                        _createAnimatedText(
                            "Want to watch adventure movies or series?"),
                        _createAnimatedText("Explore and enjoy watching!"),
                      ],
                      repeatForever: true,
                      pause: const Duration(seconds: 3),
                    ),
                  )
                : const SizedBox.shrink(),
          ]);
        }),
      ),
    );
  }

  Widget _buildRightIcons(BuildContext context, StateSetter setState) {
    return Expanded(
      flex: _textController.text.isNotEmpty ? 2 : 1,
      child: Row(
        children: [
          _textController.text.isNotEmpty == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: GestureDetector(
                      onTap: () => setState(() {
                            _textController.clear();
                            onSearchCallBack?.call(
                                context, _textController.text);
                          }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.grey)),
                        child: const Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(color: Colors.black, blurRadius: 15.0)
                          ],
                        ),
                      )),
                )
              : const SizedBox.shrink(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              CustomIcons.filter,
              color: Colors.white,
              size: 18,
              shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 15.0)],
            ),
          )
        ],
      ),
    );
  }

  TyperAnimatedText _createAnimatedText(String text) {
    return TyperAnimatedText(
      text,
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: "SfProTextMedium",
      ),
    );
  }
}

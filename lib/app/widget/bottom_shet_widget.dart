// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomSheetWidget extends StatefulWidget {
  final Widget child;
  final bool? canShowBottomList;
  final VoidCallback? onPanelClosed;
  double? panelHeightOpen;
  double? panelHeightClosed;
  BottomSheetWidget(
      {super.key,
      required this.child,
      required this.canShowBottomList,
      this.panelHeightOpen,
      this.panelHeightClosed,
      this.onPanelClosed});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        color: Colors.blueGrey.shade900,
        backdropEnabled: true,
        maxHeight:
            widget.panelHeightOpen ?? MediaQuery.of(context).size.height / 2,
        minHeight: widget.panelHeightClosed ?? 0,
        onPanelClosed: widget.onPanelClosed,
        defaultPanelState: widget.canShowBottomList == true
            ? PanelState.OPEN
            : PanelState.CLOSED,
        panelBuilder: (sc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [TopButtonIndicator(), widget.child]),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)));
  }

  Widget TopButtonIndicator() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Wrap(children: <Widget>[
            Container(
                width: 100,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                )),
          ])),
        ]);
  }
}

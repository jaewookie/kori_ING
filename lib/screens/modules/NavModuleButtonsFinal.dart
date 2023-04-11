import 'package:flutter/material.dart';

class NavModuleButtonsFinal extends StatefulWidget {
  final int? screens;

  const NavModuleButtonsFinal({
    Key? key,
    this.screens,
  }) : super(key: key);

  @override
  State<NavModuleButtonsFinal> createState() => _NavModuleButtonsFinalState();
}

class _NavModuleButtonsFinalState extends State<NavModuleButtonsFinal> {
  double pixelRatio = 0.75;

  late List<double> buttonPositionWidth;
  late List<double> buttonPositionHeight;
  late List<double> buttonSize;

  late double buttonRadius;

  late List<double> buttonSize1;
  late List<double> buttonSize2;

  late int buttonNumbers;

  int buttonWidth = 0;
  int buttonHeight = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.screens == 0) {
      // 메인 화면
      buttonPositionWidth = [143, 143, 743, 747];
      buttonPositionHeight = [400, 400, 1021, 1021];

      buttonSize = [570, 565];

      buttonRadius = 30;
    } else if (widget.screens == 1) {
      // 서빙 일시 정지
      buttonPositionWidth = [143, 143, 743];
      buttonPositionHeight = [1015, 1291, 1291];

      buttonSize = [];
      buttonSize1 = [1155, 230];
      buttonSize2 = [555, 325];

      buttonRadius = 50;
    } else if (widget.screens == 2) {

    } else if (widget.screens == 3) {
      // 서빙 상품 선택 화면

    } else if (widget.screens == 4) {
      // 서빙 테이블 선택 화면

    } else if (widget.screens == 5) {

    } else if (widget.screens == 6) {

    }

    buttonNumbers = buttonPositionHeight.length;

    return Stack(children: [
      for (int i = 0; i < buttonNumbers; i++)
        Positioned(
          left: buttonPositionWidth[i] * pixelRatio,
          top: buttonPositionHeight[i] * pixelRatio,
          child: FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    // side: BorderSide(width: 1, color: Colors.redAccent),
                    borderRadius:
                        BorderRadius.circular(buttonRadius * pixelRatio)),
                fixedSize: widget.screens == 1
                    ? i == 0
                        ? Size(buttonSize1[buttonWidth] * pixelRatio,
                            buttonSize1[buttonHeight] * pixelRatio)
                        : Size(buttonSize2[buttonWidth] * pixelRatio,
                            buttonSize2[buttonHeight] * pixelRatio)
                    : Size(buttonSize[buttonWidth] * pixelRatio,
                        buttonSize[buttonHeight] * pixelRatio)),
            onPressed: widget.screens == 0
                ? () {}
                : widget.screens == 1
                    ? () {
                        if (i == 0) {
                          // 추후에는 API 통신을 이용한 일시정지 추가
                          Navigator.pop(context);
                        } else if (i == 1) {
                          // 추후에는 API 통신을 이용한 충전하러가기 기능 추가
                          Navigator.pop(context);
                        } else {
                          // 추후에는 골 포지션 변경을 하며 자율주행 명령 추가
                          Navigator.pop(context);
                        }
                      }
                    : widget.screens == 2
                        ? () {}
                        : widget.screens == 3
                            ? () {}
                            : widget.screens == 4
                                ? () {}
                                : widget.screens == 5
                                    ? () {}
                                    : widget.screens == 6
                                        ? () {}
                                        : null,
            child: null,
          ),
        ),
    ]);
  }
}

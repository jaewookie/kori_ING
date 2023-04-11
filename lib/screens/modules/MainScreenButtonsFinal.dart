import 'package:flutter/material.dart';

import 'package:kori_test_refactoring/Utills/navScreens.dart';

import 'package:kori_test_refactoring/screens/AdminScreen.dart';
import 'package:kori_test_refactoring/screens/ConfigScreen.dart';
import 'package:kori_test_refactoring/screens/LinkConnectorScreen.dart';
import 'package:kori_test_refactoring/screens/ServiceScreenFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/hotel/HotelServiceMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving_final/TraySelectionFinal.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingMenu.dart';

class MainScreenButtonsFinal extends StatefulWidget {
  final int? screens;

  const MainScreenButtonsFinal({
    Key? key,
    this.screens,
  }) : super(key: key);

  @override
  State<MainScreenButtonsFinal> createState() => _MainScreenButtonsFinalState();
}

class _MainScreenButtonsFinalState extends State<MainScreenButtonsFinal> {

  late var screenList = List<Widget>.empty();
  late var serviceList = List<Widget>.empty();

  late var homeButtonName = List<String>.empty();

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
  void initState() {
    // TODO: implement initState
    super.initState();

    screenList = [
      const ServiceScreenFinal(),
      const LinkConnectorScreen(),
      const AdminScreen(),
      const ConfigScreen()
    ];
    serviceList = [ShippingMenu(), TraySelectionFinal(), HotelServiceMenu()];
  }

  @override
  Widget build(BuildContext context) {

    if (widget.screens == 0) {
      // 메인 화면
      buttonPositionWidth = [121, 747, 121, 747];
      buttonPositionHeight = [400, 400, 1021, 1021];

      buttonSize = [570, 565];

      buttonRadius = 30;
    } else if (widget.screens == 1) {
      // 서비스 선택화면
      buttonPositionWidth = [121, 121, 121];
      buttonPositionHeight = [400, 723, 1046];

      buttonSize = [1198, 256];

      buttonRadius = 30;
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
                fixedSize: Size(buttonSize[buttonWidth] * pixelRatio,
                    buttonSize[buttonHeight] * pixelRatio)),
            onPressed: widget.screens == 0
                ? () {
                    navPage(
                            context: context,
                            page: screenList[i],
                            enablePop: true)
                        .navPageToPage();
                    // _networkProvider.serviceState = i;
                  }
                : widget.screens == 1
                    ? () {
                        if (i == 0) {
                          navPage(
                                  context: context,
                                  page: serviceList[i],
                                  enablePop: true)
                              .navPageToPage();
                        } else if (i == 1) {
                          navPage(
                                  context: context,
                                  page: serviceList[i],
                                  enablePop: true)
                              .navPageToPage();
                        } else {
                          navPage(
                                  context: context,
                                  page: serviceList[i],
                                  enablePop: true)
                              .navPageToPage();
                        }
                      }
                    : null,
            child: null,
          ),
        ),
    ]);
  }
}
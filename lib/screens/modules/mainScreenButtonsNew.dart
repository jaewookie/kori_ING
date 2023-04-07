import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
// import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/screens/AdminScreen.dart';
import 'package:kori_test_refactoring/screens/ConfigScreen.dart';
import 'package:kori_test_refactoring/screens/LinkConnectorScreen.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/Service/hotel/HotelServiceMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingMenu.dart';

class FinalMainScreenButtons extends StatefulWidget {
  final int? screens;

  const FinalMainScreenButtons(
      {Key? key,
        this.screens,
        })
      : super(key: key);

  @override
  State<FinalMainScreenButtons> createState() => _FinalMainScreenButtonsState();
}

class _FinalMainScreenButtonsState extends State<FinalMainScreenButtons> {

  // dynamic poseData;

  late var screenList = List<Widget>.empty();
  late var serviceList = List<Widget>.empty();

  double pixelRatio = 0.75;

  late List<double> buttonPositionWidth;
  late List<double> buttonPositionHeight;
  late List<double> buttonSize;

  late int buttonNumbers;

  int buttonWidth = 0;
  int buttonHeight = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // poseDataUpdate(widget.parsePoseData);

    screenList = [const ServiceScreen(), const LinkConnectorScreen(), const AdminScreen(), const ConfigScreen()];
    serviceList = [ShippingMenu(), TraySelection3(), HotelServiceMenu()];
  }

  @override
  Widget build(BuildContext context) {

    if(widget.screens == 0){
      buttonPositionWidth = [121, 747, 121, 747];
      buttonPositionHeight = [400, 400, 1021, 1021];

      buttonSize = [570, 565];
    }else if(widget.screens == 1){
      buttonPositionWidth = [121, 121, 121];
      buttonPositionHeight = [400, 723, 1046];

      buttonSize = [1198, 256];
    }


    buttonNumbers = buttonPositionHeight.length;

    return Stack(
      children: [
        for (int i = 0; i < buttonNumbers; i++)
          Positioned(
            left: buttonPositionWidth[i]*pixelRatio,
            top: buttonPositionHeight[i]*pixelRatio,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30*pixelRatio)),
                  fixedSize: Size(buttonSize[buttonWidth] * pixelRatio, buttonSize[buttonHeight] * pixelRatio)),
              onPressed: () {
                if(widget.screens == 0){
                  navPage(context: context, page: screenList[i], enablePop: true).navPageToPage();
                }else if(widget.screens == 1){
                  navPage(context: context, page: serviceList[i], enablePop: true).navPageToPage();
                }
              },
              child: null,
            ),
          ),
      ]
    );
  }
}
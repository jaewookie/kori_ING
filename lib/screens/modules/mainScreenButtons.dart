import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/screens/AdminScreen.dart';
import 'package:kori_test_refactoring/screens/ConfigScreen.dart';
import 'package:kori_test_refactoring/screens/LinkConnectorScreen.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';

class MainScreenButtons extends StatefulWidget {
  final List<String>? buttonName;
  final List<IconData>? buttonIcon;
  final double? buttonIconSize;
  final double? widthRatio;
  final double? heightRatio;
  final String? hostUrl;
  final TextStyle? buttonFont;

  const MainScreenButtons(
      {Key? key,
      this.buttonName,
      this.buttonIconSize,
      this.buttonIcon,
      this.widthRatio,
      this.heightRatio,
      this.hostUrl,
      this.buttonFont})
      : super(key: key);

  @override
  State<MainScreenButtons> createState() => _MainScreenButtonsState();
}

class _MainScreenButtonsState extends State<MainScreenButtons> {

  // dynamic poseData;

  late var screenList = List<Widget>.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // poseDataUpdate(widget.parsePoseData);

    screenList = [const ServiceScreen(), const LinkConnectorScreen(), const AdminScreen(), const ConfigScreen()];
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double? textButtonWidth;
    double? textButtonHeight;

    if (widget.widthRatio == null) {
      textButtonWidth = screenWidth;
    } else {
      textButtonWidth = screenWidth * widget.widthRatio!;
    }
    if (widget.heightRatio == null) {
      textButtonHeight = screenHeight;
    } else {
      textButtonHeight = screenHeight * widget.heightRatio!;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                      MenuButtons(
                          assetsBool: i==0?true:false,
                          onPressed: (){
                            navPage(context: context, page: screenList[i], enablePop: true).navPageToPage();
                          },
                          buttonText: widget.buttonName![i],
                          appIcon: widget.buttonIcon![i],
                          iconAsset: 'assets/logos/ExaIcon.png',
                          buttonIconSize: widget.buttonIconSize,
                          buttonWidth: textButtonWidth,
                          buttonHeight: textButtonHeight,
                          buttonColor: const Color.fromRGBO(45, 45, 45, 45),
                          buttonFont: widget.buttonFont),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
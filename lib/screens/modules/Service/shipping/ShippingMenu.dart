import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingDestinationModule.dart';
import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingDestinationModuleNew.dart';
import 'package:provider/provider.dart';

// ------------------------------ 보류 ---------------------------------------

class ShippingMenu extends StatefulWidget {
  ShippingMenu({Key? key}) : super(key: key);

  @override
  State<ShippingMenu> createState() => _ShippingMenuState();
}

class _ShippingMenuState extends State<ShippingMenu> {
  late NetworkModel _networkProvider;

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.85;
    double textButtonHeight = screenHeight * 0.15;

    TextStyle? buttonFont = Theme.of(context).textTheme.displayLarge;
    TextStyle? buttonFont2 = Theme.of(context).textTheme.displayMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Color(0xffB7B7B7),
          iconSize: screenHeight * 0.03,
          alignment: Alignment.centerRight,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            onPressed: () {
              navPage(context: context, page: ServiceScreen(), enablePop: false)
                  .navPageToPage();
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.03,
            alignment: Alignment.center,
          ),
          Icon(Icons.battery_charging_full,
              color: Colors.teal, size: screenHeight * 0.03),
          SizedBox(width: screenWidth * 0.03)
        ],
        toolbarHeight: screenHeight * 0.045,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: screenHeight * 0.05),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: Container(
          // width: screenWidth * 0.85,
          // height: screenHeight * 0.8,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '배달하실 물품을',
                          style: buttonFont2,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '선반에 올려놓으신 후',
                          style: buttonFont2,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '[다음]버튼을 눌러주세요.',
                          style: buttonFont2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      TextButton(
                          onPressed: () {
                            navPage(context: context, page: ShippingDestinationNew(), enablePop: true).navPageToPage();
                            print(_networkProvider.goalPosition);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xff2D2D2D),
                              fixedSize: Size(textButtonWidth, textButtonHeight),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFB7B7B7),
                                      style: BorderStyle.solid,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(40))),
                          child: Stack(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: textButtonWidth * 0.035,
                                    ),
                                    SizedBox(
                                      width: textButtonWidth * 0.33,
                                      child: const Icon(
                                        Icons.play_circle_outline_rounded,
                                        color: Color(0xffF0F0F0),
                                        size: 120,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "다음",
                                      style: buttonFont,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.005,
                                )
                              ],
                            ),
                          ]))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

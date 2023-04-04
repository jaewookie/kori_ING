import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/screens/MainScreen.dart';
import 'package:kori_test_refactoring/screens/modules/config/ip_change.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.85;
    double textButtonHeight = screenHeight * 0.15;

    TextStyle? buttonFont = Theme.of(context).textTheme.displayLarge;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            // padding: EdgeInsets.only(right: screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(
                0, screenHeight * 0.0015, screenWidth * 0.05, 0),
            onPressed: () {
              navPage(context: context, page: MainScreen(), enablePop: false).navPageToPage();
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.05,
          )
        ],
        toolbarHeight: screenHeight * 0.08,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/KoriBackgroundImage_v1.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuButtons(
                  assetsBool: false,
                  onPressed: () {
                    navPage(context: context, page: IpChange(), enablePop: true).navPageToPage();
                  },
                  appIcon: Icons.add_link,
                  buttonText: 'IP 변경',
                  buttonHeight: textButtonHeight,
                  buttonWidth: textButtonWidth,
                  buttonFont: buttonFont,
                  buttonIconSize: 120,
                  buttonColor: Color.fromRGBO(45, 45, 45, 45),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

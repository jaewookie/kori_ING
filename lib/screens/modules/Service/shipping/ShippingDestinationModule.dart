import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/ShippingButtons.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

class ShippingDestination extends StatefulWidget {
  ShippingDestination({
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingDestination> createState() => _ShippingDestinationState();
}

class _ShippingDestinationState extends State<ShippingDestination> {
  late NetworkModel _networkProvider;
  String? currentGoal;

  String? startUrl;
  String? navUrl;
  String? chgUrl;
  String? stpUrl;
  String? rsmUrl;

  late var goalPosition = List<String>.empty();

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double textButtonWidth = screenWidth * 0.34; //0.4
    double textButtonHeight = screenHeight * 0.105; //0.7

    TextStyle? goalFont = Theme.of(context).textTheme.headlineLarge;

    // currentGoal = _networkProvider.currentGoal;
    goalPosition = _networkProvider.goalPosition;
    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;
    stpUrl = _networkProvider.stpUrl;
    rsmUrl = _networkProvider.rsmUrl;

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
        child: Column(
          children: [
            for (int i = 0; i < (goalPosition.length / 2); i++)
              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if ((2 * i) + 2 <= goalPosition.length)
                        for (int j = (2 * i); j < ((2 * i) + 2); j++)
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              ShippingButtons(
                                  onPressed: () {
                                    if (goalPosition[j].toString() !=
                                        "charging_pile") {
                                      PostApi(
                                          url: startUrl,
                                          endadr: navUrl,
                                          keyBody:
                                              goalPosition[j].toString()).Posting();
                                      _networkProvider.currentGoal =
                                          goalPosition[j].toString();
                                      navPage(context: context, page: NavigatorModule(), enablePop: true).navPageToPage();
                                    } else {
                                      PostApi(
                                          url: startUrl,
                                          endadr: chgUrl,
                                          keyBody:
                                              goalPosition[j].toString()).Posting();
                                      _networkProvider.currentGoal = '충전스테이션';
                                      navPage(context: context, page: NavigatorModule(), enablePop: true).navPageToPage();
                                    }
                                  },
                                  buttonText:
                                      goalPosition[j] == 'charging_pile'
                                          ? "충전기"
                                          : goalPosition[j],
                                  buttonWidth: textButtonWidth,
                                  buttonHeight: textButtonHeight,
                                  buttonColor: Color.fromRGBO(45, 45, 45, 45),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  buttonFont: goalFont),
                              SizedBox(
                                width: screenWidth * 0.02,
                              )
                            ],
                          )
                      else
                        Row(
                          children: [
                            ShippingButtons(
                                onPressed: () {
                                  PostApi(
                                      url: startUrl,
                                      endadr: navUrl,
                                      keyBody:
                                      goalPosition.last.toString()).Posting();

                                  // setState(() {
                                  //   currentGoal = '충전스테이션';
                                  // });
                                  _networkProvider.currentGoal = goalPosition.last;
                                },
                                buttonText: goalPosition.last,
                                buttonWidth: textButtonWidth,
                                buttonHeight: textButtonHeight,
                                buttonColor: Color.fromRGBO(45, 45, 45, 45),
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                buttonFont: goalFont),
                            SizedBox(
                              width: textButtonWidth*1.12,
                              height: textButtonHeight * 0.7,
                            )
                          ],
                        )
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

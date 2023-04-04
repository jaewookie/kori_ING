import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/Widgets/ShippingButtons.dart';
import 'package:provider/provider.dart';

class ShippingDestinationModal extends StatefulWidget {
  const ShippingDestinationModal({Key? key}) : super(key: key);

  @override
  State<ShippingDestinationModal> createState() =>
      _ShippingDestinationModalState();
}

class _ShippingDestinationModalState extends State<ShippingDestinationModal> {
  late NetworkModel _networkProvider;

  String? startUrl;
  String? navUrl;
  String? chgUrl;
  String? stpUrl;
  String? rsmUrl;

  late var goalPosition = List<String>.empty();

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    goalPosition = _networkProvider.goalPosition;
    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;
    stpUrl = _networkProvider.stpUrl;
    rsmUrl = _networkProvider.rsmUrl;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double textButtonWidth = screenWidth * 0.34; //0.4
    double textButtonHeight = screenHeight * 0.105; //0.7

    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    return Container(
      margin:
          EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, screenHeight * 0.15),
      child: Dialog(
        backgroundColor: Color(0xff000000),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Color(0xFFB7B7B7),
              style: BorderStyle.solid,
              width: 1,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel_presentation_outlined),
                      color: const Color(0xffF0F0F0),
                      iconSize: 60,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, screenHeight * 0.1, 0, screenHeight * 0.015),
                  width: screenWidth,
                  height: screenHeight * 0.64,
                  child: Scrollbar(
                    thickness: 4.0,
                    radius: Radius.circular(8.0),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (BuildContext, int index) {
                          return Column(
                            children: [
                              for (int i = 0;
                                  i < (goalPosition.length / 2);
                                  i++)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if ((2 * i) + 2 <= goalPosition.length)
                                          for (int j = (2 * i);
                                              j < ((2 * i) + 2);
                                              j++)
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
                                                    buttonFont: tableButtonFont),
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
                                                  buttonFont: tableButtonFont),
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
                          );
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '배송지 목록 스크린',
                      style: TextStyle(
                          fontSize: 80,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
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

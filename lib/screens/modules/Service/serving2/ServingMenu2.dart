import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/OrderedMenuButtons.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving2/TraySelection2.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

// 화면을 이용한 UI
// ------------------------------ 보류 ---------------------------------------

class ServingMenu2 extends StatefulWidget {
  ServingMenu2({Key? key}) : super(key: key);

  @override
  State<ServingMenu2> createState() => _ServingMenu2State();
}

class _ServingMenu2State extends State<ServingMenu2> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? startUrl;
  String? navUrl;
  String? chgUrl;

  bool? trayStatus1;
  bool? trayStatus2;
  bool? trayStatus3;

  late var goalPosition = List<String>.empty();
  List<String> orderedItems = [];

  List<String> testItems = ['햄버거', '라면', '치킨', '핫도그', '미주문'];

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;

    print('service : ${_networkProvider.serviceState}');

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.45;
    double textButtonHeight = screenHeight * 0.15;

    TextStyle? textFont = Theme.of(context).textTheme.displayMedium;
    TextStyle? tableButtonFont = Theme.of(context).textTheme.headlineLarge;

    goalPosition = _networkProvider.goalPosition;

    trayStatus1 = _servingProvider.tray1;
    trayStatus2 = _servingProvider.tray2;
    trayStatus3 = _servingProvider.tray3;

    print("tray1 : ${trayStatus1}");
    print("tray2 : ${trayStatus2}");
    print("tray3 : ${trayStatus3}");

    if(orderedItems.length == 0){
      for (int i = 0; i < _networkProvider.goalPosition.length; i++) {
        orderedItems.add(testItems[Random().nextInt(testItems.length)]);
        print(orderedItems);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            navPage(context: context, page: ServiceScreen(), enablePop: false).navPageToPage();
            _servingProvider.initServing();
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
          IconButton(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            onPressed: () {
              PostApi(
                  url: startUrl,
                  endadr: chgUrl,
                  keyBody:'charging_pile').Posting();
              _networkProvider.currentGoal = '충전스테이션';
              _networkProvider.servingDone = true;
              navPage(context: context, page: NavigatorModule(), enablePop: true).navPageToPage();
            },
            icon: Icon(
              Icons.charging_station_outlined,
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
        // padding: EdgeInsets.only(top: screenHeight * 0.05),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
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
                          '주문을 확인해주세요.',
                          style: textFont,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                      ),
                      width: textButtonWidth*0.7,
                      height: textButtonHeight * 0.45,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(textButtonWidth * 0.1,
                            textButtonHeight * 0.025, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '1번 트레이',
                                  style: tableButtonFont,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(trayStatus1==true)
                                Text(
                                  '${_servingProvider.table1}번 ${_servingProvider.item1}',
                                  style: tableButtonFont,
                                )else
                                  Text('미선택',
                                    style: tableButtonFont,)
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                      ),
                      width: textButtonWidth*0.7,
                      height: textButtonHeight * 0.45,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(textButtonWidth * 0.1,
                            textButtonHeight * 0.025, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '2번 트레이',
                                  style: tableButtonFont,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(trayStatus2==true)
                                  Text(
                                    '${_servingProvider.table2}번 ${_servingProvider.item2}',
                                    style: tableButtonFont,
                                  )else
                                  Text('미선택',
                                    style: tableButtonFont,)
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                      ),
                      width: textButtonWidth*0.7,
                      height: textButtonHeight * 0.45,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(textButtonWidth * 0.1,
                            textButtonHeight * 0.025, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '3번 트레이',
                                  style: tableButtonFont,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(trayStatus3==true)
                                  Text(
                                    '${_servingProvider.table3}번 ${_servingProvider.item3}',
                                    style: tableButtonFont,
                                  )else
                                  Text('미선택',
                                    style: tableButtonFont,)
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.23),
              width: screenWidth,
              height: screenHeight * 0.83,
              child: Scrollbar(
                thickness: 4.0,
                radius: Radius.circular(8.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (BuildContext, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < (goalPosition.length / 2); i++)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if ((2 * i) + 2 <= goalPosition.length)
                                      for (int j = (2 * i);
                                          j < ((2 * i) + 2);
                                          j++)
                                        Row(
                                          children: [
                                            SizedBox(
                                                ),
                                            OrderedMenuButtons(
                                                onPressed: () {
                                                  navPage(context: context, page: TraySelection2(), enablePop: true).navPageToPage();
                                                  _servingProvider.menuItem = orderedItems[j];
                                                  _servingProvider.tableNumber = goalPosition[j];
                                                  print(orderedItems[j]);
                                                },
                                                buttonText: goalPosition[j],
                                                itemName: orderedItems[j],
                                                buttonWidth: textButtonWidth,
                                                buttonHeight: textButtonHeight,
                                                buttonColor: Color.fromRGBO(
                                                    45, 45, 45, 45),
                                                screenWidth: screenWidth,
                                                screenHeight: screenHeight,
                                                buttonFont: tableButtonFont),
                                          ],
                                        )
                                    else
                                      Row(
                                        children: [
                                          OrderedMenuButtons(
                                              onPressed: () {
                                                navPage(context: context, page: TraySelection2(), enablePop: true).navPageToPage();
                                                print(orderedItems.last);
                                                _servingProvider.menuItem = orderedItems.last;
                                                _servingProvider.tableNumber = goalPosition.last;
                                              },
                                              buttonText: goalPosition.last,
                                              itemName: orderedItems.last,
                                              buttonWidth: textButtonWidth,
                                              buttonHeight: textButtonHeight,
                                              buttonColor: Color.fromRGBO(
                                                  45, 45, 45, 45),
                                              screenWidth: screenWidth,
                                              screenHeight: screenHeight,
                                              buttonFont: tableButtonFont),
                                          SizedBox(
                                            width: textButtonWidth * 1.12,
                                            height: textButtonHeight * 0.7,
                                          )
                                        ],
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                              ],
                            ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}

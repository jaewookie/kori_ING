import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Providers/ServingModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingMenu.dart';
import 'package:kori_test_refactoring/screens/modules/Service/serving/TrayStatus.dart';
import 'package:provider/provider.dart';

class TrayChecker extends StatefulWidget {
  const TrayChecker({Key? key}) : super(key: key);

  @override
  State<TrayChecker> createState() => _TrayCheckerState();
}

class _TrayCheckerState extends State<TrayChecker> {
  late NetworkModel _networkProvider;
  late ServingModel _servingProvider;

  String? tableNumber;
  String? itemName;

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  void showPopup(context, int trayNumbers) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('선반위 상품을 변경하시겠습니까?'),
            backgroundColor: Color(0xff2C2C2C),
            contentTextStyle: Theme.of(context).textTheme.headlineLarge,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Color(0xFFB7B7B7),
                  style: BorderStyle.solid,
                  width: 1,
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        if (trayNumbers == 1) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray1();
                        } else if (trayNumbers == 2) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray2();
                        } else if (trayNumbers == 3) {
                          _servingProvider.trayCheckAll = false;
                          _servingProvider.setTray3();
                        } else {
                          _servingProvider.trayCheckAll = true;
                          _servingProvider.setTrayAll();
                        }
                        navPage(
                                context: context,
                                page: TrayStatus(),
                                enablePop: true)
                            .navPageToPage();
                      },
                      child: Text('확인')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('취소'))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);
    _servingProvider = Provider.of<ServingModel>(context, listen: false);

    itemName = _servingProvider.menuItem;
    tableNumber = _servingProvider.tableNumber;

    print('item :: ${itemName}');
    print(tableNumber);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textButtonWidth = screenWidth * 0.6;
    double textButtonHeight = screenHeight * 0.08;

    TextStyle? textFont1 = Theme.of(context).textTheme.displayMedium;
    TextStyle? textFont2 = Theme.of(context).textTheme.displaySmall;
    TextStyle? buttonFont = Theme.of(context).textTheme.displaySmall;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            navPage(context: context, page: ServingMenu(), enablePop: false)
                .navPageToPage();
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
        // padding: EdgeInsets.only(top: screenHeight * 0),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        // child: Container(
        //   width: screenWidth * 0.85,
        //   height: screenHeight * 0.8,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('상품을 선반에 올린 후 ', style: textFont1),
                          Text('선번 번호를 눌러주세요.', style: textFont1),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Column(
                            children: [
                              Text('${tableNumber!}번 테이블 ', style: textFont2),
                              Text('$itemName', style: textFont2),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.36),
                  child: SizedBox(
                    height: screenHeight * 0.43,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (_servingProvider.tray1 == true) {
                                showPopup(context, 1);
                              } else {
                                _servingProvider.setTray1();
                                navPage(
                                        context: context,
                                        page: TrayStatus(),
                                        enablePop: true)
                                    .navPageToPage();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "트레이 1번",
                                  style: buttonFont,
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(45, 45, 45, 45),
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(40)))),
                        TextButton(
                            onPressed: () {
                              if (_servingProvider.tray2 == true) {
                                showPopup(context, 2);
                              } else {
                                _servingProvider.setTray2();
                                navPage(
                                        context: context,
                                        page: TrayStatus(),
                                        enablePop: true)
                                    .navPageToPage();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "트레이 2번",
                                  style: buttonFont,
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(45, 45, 45, 45),
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(40)))),
                        TextButton(
                            onPressed: () {
                              if (_servingProvider.tray3 == true) {
                                showPopup(context, 3);
                              } else {
                                _servingProvider.setTray3();
                                navPage(
                                        context: context,
                                        page: TrayStatus(),
                                        enablePop: true)
                                    .navPageToPage();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "트레이 3번",
                                  style: buttonFont,
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(45, 45, 45, 45),
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(40)))),
                        TextButton(
                            onPressed: () {
                              if ((_servingProvider.tray1 == true ||
                                      _servingProvider.tray2 == true) ||
                                  _servingProvider.tray3 == true) {
                                showPopup(context, 4);
                              } else {
                                _servingProvider.setTrayAll();
                                _servingProvider.trayCheckAll = true;
                                navPage(
                                        context: context,
                                        page: TrayStatus(),
                                        enablePop: true)
                                    .navPageToPage();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "전체 트레이",
                                  style: buttonFont,
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(45, 45, 45, 45),
                                fixedSize:
                                    Size(textButtonWidth, textButtonHeight),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFB7B7B7),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(40)))),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        // ),
      ),
    );
  }
}

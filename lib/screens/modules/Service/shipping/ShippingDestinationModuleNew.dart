import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/ShippingModules/ShippingDestinationsModal.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:provider/provider.dart';

class ShippingDestinationNew extends StatefulWidget {
  ShippingDestinationNew({
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingDestinationNew> createState() => _ShippingDestinationNewState();
}

class _ShippingDestinationNewState extends State<ShippingDestinationNew> {
  late NetworkModel _networkProvider;
  String? currentGoal;

  String? startUrl;
  String? navUrl;
  String? chgUrl;
  String? stpUrl;
  String? rsmUrl;

  bool? goalChecker;

  late dynamic responsePostMSG;

  late var goalPosition = List<String>.empty();

  String backgroundImage = "assets/images/KoriBackgroundImage_v1.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentGoal = "";
    goalChecker = false;
  }

  void showDestinationListPopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ShippingDestinationModal();
        });
  }

  void showGoalFalsePopup(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          return AlertDialog(
            content: SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('목적지를 잘 못 입력하였습니다.'),
                ],
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '확인',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    style: TextButton.styleFrom(
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                        Size(screenWidth * 0.5, screenHeight * 0.04)),
                  ),
                ],
              )
            ],
            // actionsPadding: EdgeInsets.only(top: screenHeight * 0.001),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double numberButtonWidth = screenWidth * 0.25;
    double numberButtonHeight = screenWidth * 0.25;

    TextStyle? padFont = Theme.of(context).textTheme.displayMedium;
    TextStyle? numberFont = Theme.of(context).textTheme.displaySmall;

    // currentGoal = _networkProvider.currentGoal;
    goalPosition = _networkProvider.goalPosition;
    startUrl = _networkProvider.startUrl;
    navUrl = _networkProvider.navUrl;
    chgUrl = _networkProvider.chgUrl;
    stpUrl = _networkProvider.stpUrl;
    rsmUrl = _networkProvider.rsmUrl;

    print('checker');
    print(goalChecker);

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
        // padding: EdgeInsets.only(top: screenHeight * 0.05),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: screenHeight * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentGoal = "";
                              });
                            },
                            icon: Icon(Icons.restart_alt),
                            iconSize: 80,
                            color: Color(0xffF0F0F0)),
                        IconButton(
                            onPressed: () {
                              showDestinationListPopup(context);
                            },
                            icon: Icon(Icons.view_list_outlined),
                            iconSize: 80,
                            color: Color(0xffF0F0F0)),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.2,
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.only(top: screenHeight * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentGoal == null
                        ? Container()
                        : Text(
                            '$currentGoal',
                            style: padFont,
                          ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: [
                for (int i = 0; i < 3; i++)
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 0; j < 3; j++)
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      if (currentGoal!.length < 3){
                                        setState(() {
                                          if (currentGoal! == null) {
                                            currentGoal = '${3 * i + j + 1}';
                                          } else {
                                            currentGoal =
                                            '$currentGoal${3 * i + j + 1}';
                                          }

                                        });
                                      }
                                      print(currentGoal);
                                    },
                                    child: Text(
                                      "${3 * i + j + 1}",
                                      style: numberFont,
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromRGBO(45, 45, 45, 45),
                                        fixedSize: Size(numberButtonWidth,
                                            numberButtonHeight),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0xFFB7B7B7),
                                                style: BorderStyle.solid,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(80)))),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (currentGoal!.length != 0) {
                            setState(() {
                              currentGoal = currentGoal!
                                  .substring(0, currentGoal!.length - 1);
                            });
                          }
                          print(currentGoal);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 130,
                          color: Color(0xffF0F0F0),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize:
                                Size(numberButtonWidth, numberButtonHeight),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 5),
                                borderRadius: BorderRadius.circular(80)))),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          if (currentGoal!.length < 3){
                            setState(() {
                              if (currentGoal! == null) {
                                currentGoal = '0';
                              } else {
                                currentGoal =
                                '${currentGoal}0';
                              }
                            });
                          }
                          print(currentGoal);
                        },
                        child: Text(
                          "0",
                          style: numberFont,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color.fromRGBO(45, 45, 45, 45),
                            fixedSize:
                                Size(numberButtonWidth, numberButtonHeight),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(0xFFB7B7B7),
                                    style: BorderStyle.solid,
                                    width: 5),
                                borderRadius: BorderRadius.circular(80)))),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          for(int i=0; i < goalPosition.length; i++){
                            if(currentGoal!.compareTo(goalPosition[i])==0){
                              setState(() {
                                goalChecker = true;
                              });
                            }
                          }
                          if(goalChecker == true){
                            print('--------------------------true-----------------------');
                            if (currentGoal != '000') {
                              PostApi(
                                  url: startUrl,
                                  endadr: navUrl,
                                  keyBody: 'shipping_$currentGoal').Posting();
                              _networkProvider.currentGoal = currentGoal;

                              navPage(context: context, page: NavigatorModule(), enablePop: true).navPageToPage();
                            } else {
                              PostApi(
                                  url: startUrl,
                                  endadr: chgUrl,
                                  keyBody: 'charging_pile').Posting();
                              _networkProvider.currentGoal = '충전스테이션';

                              navPage(context: context, page: NavigatorModule(), enablePop: true).navPageToPage();
                            }
                          }else{
                            print('--------------------------false-----------------------');
                            showGoalFalsePopup(context);
                          }
                        },
                        child: Text(
                          "출 발",
                          style: numberFont,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize:
                                Size(numberButtonWidth, numberButtonHeight),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                    width: 5),
                                borderRadius: BorderRadius.circular(80)))),
                    SizedBox(
                      width: 10,
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

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';
import 'package:kori_test_refactoring/Utills/postAPI.dart';
import 'package:kori_test_refactoring/Widgets/ShippingModules/ShippingDestinationsModal.dart';
import 'package:kori_test_refactoring/screens/ServiceScreen.dart';
import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
import 'package:kori_test_refactoring/screens/modules/ShippingModuleButtonsFinal.dart';
import 'package:provider/provider.dart';

class ShippingDestinationNewFinal extends StatefulWidget {
  ShippingDestinationNewFinal({
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingDestinationNewFinal> createState() => _ShippingDestinationNewFinalState();
}

class _ShippingDestinationNewFinalState extends State<ShippingDestinationNewFinal> {
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

  String shippingKeyPadIMG = "final_assets/screens/Shipping/koriZFinalShippingDestinations.png";

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
                  Text('목적지를 잘못 입력하였습니다.'),
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

  void showCountDownStarting(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          _networkProvider = Provider.of<NetworkModel>(context, listen: false);

          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          startUrl = _networkProvider.startUrl;
          navUrl = _networkProvider.navUrl;

          return AlertDialog(
            content: SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('5초 후 배송을 시작합니다.'),
                  Text('즉시 시작하려면 하단의 버튼을 눌러주세요'),
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
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    style: TextButton.styleFrom(
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9),
                            end: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                        Size(screenWidth * 0.27, screenHeight * 0.04)),
                  ),
                  TextButton(
                    onPressed: () {
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
                    },
                    child: Text('즉시 시작',
                        style: Theme.of(context).textTheme.headlineMedium),
                    style: TextButton.styleFrom(
                      //라운드 보더
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),side: BorderSide(
                      //     color: Colors.white,
                      //     width: 1
                      // )),
                      // 라인 보더
                        shape: LinearBorder(
                            side: BorderSide(color: Colors.white, width: 2),
                            top: LinearBorderEdge(size: 0.9)),
                        minimumSize:
                        Size(screenWidth * 0.27, screenHeight * 0.04)),
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
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(shippingKeyPadIMG), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: screenHeight * 0.07),
                child: null
            ),
            ShippingModuleButtonsFinal(screens: 1,)
          ],
        ),
      ),
    );
  }
}











// 부가기능 버튼
// IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 currentGoal = "";
//                                 goalChecker = false;
//                               });
//                             },
//                             icon: Icon(Icons.restart_alt),
//                             iconSize: 80,
//                             color: Color(0xffF0F0F0)),
//                         IconButton(
//                             onPressed: () {
//                               showDestinationListPopup(context);
//                             },
//                             icon: Icon(Icons.view_list_outlined),
//                             iconSize: 80,
//                             color: Color(0xffF0F0F0)),
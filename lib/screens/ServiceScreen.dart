// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Providers/NetworkModel.dart';

// import 'package:kori_test_refactoring/Utills/callApi.dart';
import 'package:kori_test_refactoring/Utills/navScreens.dart';

// import 'package:kori_test_refactoring/Widgets/MenuButtons.dart';
import 'package:kori_test_refactoring/screens/MainScreen.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/hotel/HotelServiceMenu.dart';

// import 'package:kori_test_refactoring/screens/modules/Service/serving/ServingMenu.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/serving2/ServingMenu2.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/serving2/TraySelection2.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/serving3/TraySelection3.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingMenu.dart';
import 'package:kori_test_refactoring/screens/modules/mainScreenButtonsNew.dart';

// import 'package:kori_test_refactoring/Widgets/NavigatorModule.dart';
// import 'package:kori_test_refactoring/screens/modules/Service/shipping/ShippingDestinationModule.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> with TickerProviderStateMixin {
  late NetworkModel _networkProvider;

  // IconData? appIcon1;
  // IconData? appIcon2;
  // IconData? appIcon3;
  // IconData? appIcon4;
  //
  // double? buttonIconSize;

  String? currentGoal;

  dynamic poseData;

  final String _wallpape = "final_assets/screens/koriZFinalService.png";
  final String _fingerIcon = "final_assets/icons/pushIcon.png";

  double pixelRatio = 0.75;

  // int screenStatus = 0;
  //
  // int? shipping;
  // int? serving;
  // int? hotel;

  // int? roomService;

  // bool? shippingCheck;
  // bool? navCheck;
  // bool? pauseCheck;
  //
  // String? startUrl;
  // String? navUrl;
  // String? chgUrl;
  // String? stpUrl;
  // String? rsmUrl;
  //
  // List<String>? goalPosition;
  //
  // int? serviceState;

  // late var servicePages = List<Widget>.empty();

  // late var homeButtonName = List<String>.empty();
  // late var homeButtonIcon = List<IconData>.empty();
  late var shippingPose = List<String>.empty();

  // late var goalPosition = List<String>.empty();

  late final AnimationController _textAniCon = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _textAniCon,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // shipping = 0;
    // serving = 1;
    // hotel = 2;
    // roomService = 3;
    //
    // appIcon1 = Icons.local_shipping_outlined;
    // appIcon2 = Icons.delivery_dining_outlined;
    // appIcon3 = Icons.hotel;
    // appIcon4 = Icons.room_service_outlined;

    // buttonIconSize = 120;

    // servicePages = [
    //   ShippingMenu(),
    //   TraySelection3(),
    //   HotelServiceMenu(),
    //   ShippingMenu()
    // ];

    // homeButtonName = ["택배", "서빙", "호텔"];
    // homeButtonName = ["택배", "서빙", "호텔", "룸서비스"];
    // homeButtonIcon = [appIcon1!, appIcon2!, appIcon3!];
    // homeButtonIcon = [appIcon1!, appIcon2!, appIcon3!, appIcon4!];
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double textButtonWidth = screenWidth * 0.85;
    // double textButtonHeight = screenHeight * 0.15;

    // TextStyle? buttonFont = Theme.of(context).textTheme.displayLarge;

    poseData = _networkProvider.getPoseData;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              navPage(context: context, page: MainScreen(), enablePop: false)
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
                navPage(context: context, page: MainScreen(), enablePop: false)
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
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(_wallpape))),
              child: Container(),
            ),
            FinalMainScreenButtons(screens: 1),
            Positioned(
                left: 670 * pixelRatio,
                top: 1829 * pixelRatio,
                child: FadeTransition(
                  opacity: _animation,
                  child: SizedBox(
                    child: ImageIcon(
                      AssetImage(_fingerIcon),
                      color: Color(0xffB7B7B7),
                      size: 100,
                    ),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 1970 * pixelRatio),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '서비스를 선택해주세요.',
                    style: TextStyle(
                        fontFamily: 'kor',
                        fontSize: 35,
                        color: Color(0xfff0f0f0)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}





//UI 작업 이전

//Container(
//               padding: EdgeInsets.only(top: screenHeight * 0.05),
//               constraints: BoxConstraints.expand(),
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(_wallpape), fit: BoxFit.cover)),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // if (screenStatus == servicePages[home])
//                       Container(
//                         width: screenWidth * 0.85,
//                         height: screenHeight * 0.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             for (int h = 0; h < homeButtonName.length; h++)
//                               MenuButtons(
//                                   assetsBool: false,
//                                   onPressed: () {
//                                     // _networkProvider.serviceState = i;
//                                     serviceState = h;
//                                     List<String> PositioningList = [];
//                                     List<String> PositionList = [];
//                                     String editPoseData = poseData.toString();
//                                     // print(editPoseData);
//                                     editPoseData =
//                                         editPoseData.replaceAll('{', "");
//                                     editPoseData =
//                                         editPoseData.replaceAll('}', "");
//                                     List<String> PositionWithCordList =
//                                         editPoseData.split("], ");
//                                     print(editPoseData);
//                                     for (int i = 0;
//                                         i < PositionWithCordList.length;
//                                         i++) {
//                                       PositioningList =
//                                           PositionWithCordList[i].split(":");
//                                       // print(PositioningList);
//                                       if (serviceState == shipping) {
//                                         for (int j = 0;
//                                             j < PositioningList.length;
//                                             j++) {
//                                           if (j == 0) {
//                                             if (PositioningList[j] ==
//                                                 'charging_pile') {
//                                               PositionList.replaceRange(
//                                                   0, 0, [PositioningList[j]]);
//                                             } else {
//                                               if (PositioningList[j]
//                                                   .contains('shipping_')) {
//                                                 shippingPose =
//                                                     PositioningList[j]
//                                                         .split('shipping_');
//                                                 shippingPose.removeAt(j);
//                                                 print(shippingPose);
//                                                 PositionList.add(
//                                                     shippingPose[j]);
//                                               }
//                                             }
//                                           }
//                                         }
//                                       } else if (serviceState == serving) {
//                                         for (int j = 0;
//                                             j < PositioningList.length;
//                                             j++) {
//                                           if (j == 0) {
//                                             if (PositioningList[j] !=
//                                                 'charging_pile') {
//                                               if (PositioningList[j]
//                                                   .contains('serving_')) {
//                                                 shippingPose =
//                                                     PositioningList[j]
//                                                         .split('serving_');
//                                                 shippingPose.removeAt(j);
//                                                 print(shippingPose);
//                                                 PositionList.add(
//                                                     shippingPose[j]);
//                                               }
//                                               //   PositionList.replaceRange(
//                                               //       0, 0, [PositioningList[j]]);
//                                               // } else {
//                                             }
//                                           }
//                                         }
//                                       } else if (serviceState == hotel) {
//                                         for (int j = 0;
//                                             j < PositioningList.length;
//                                             j++) {
//                                           if (j == 0) {
//                                             if (PositioningList[j] ==
//                                                 'charging_pile') {
//                                               PositionList.replaceRange(
//                                                   0, 0, [PositioningList[j]]);
//                                             } else {
//                                               if (PositioningList[j]
//                                                   .contains('room_')) {
//                                                 shippingPose =
//                                                     PositioningList[j]
//                                                         .split('room_');
//                                                 shippingPose.removeAt(j);
//                                                 print(shippingPose);
//                                                 PositionList.add(
//                                                     shippingPose[j]);
//                                               }
//                                             }
//                                           }
//                                         }
//                                       } else {
//                                         for (int j = 0;
//                                             j < PositioningList.length;
//                                             j++) {
//                                           if (j == 0) {
//                                             if (PositioningList[j] ==
//                                                 'charging_pile') {
//                                               PositionList.replaceRange(
//                                                   0, 0, [PositioningList[j]]);
//                                             } else {
//                                               if (PositioningList[j]
//                                                   .contains('room_')) {
//                                                 shippingPose =
//                                                     PositioningList[j]
//                                                         .split('room_');
//                                                 shippingPose.removeAt(j);
//                                                 print(shippingPose);
//                                                 PositionList.add(
//                                                     shippingPose[j]);
//                                               }
//                                             }
//                                           }
//                                         }
//                                       }
//                                       _networkProvider.goalPosition =
//                                           PositionList;
//                                     }
//                                     _networkProvider.serviceState = h;
//                                     navPage(
//                                             context: context,
//                                             page: servicePages[h],
//                                             enablePop: true)
//                                         .navPageToPage();
//                                   },
//                                   buttonText: homeButtonName[h],
//                                   appIcon: homeButtonIcon[h],
//                                   buttonIconSize: buttonIconSize,
//                                   buttonWidth: textButtonWidth,
//                                   buttonHeight: textButtonHeight,
//                                   buttonColor: Color.fromRGBO(45, 45, 45, 45),
//                                   buttonFont: buttonFont),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             )